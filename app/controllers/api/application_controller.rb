# frozen_string_literal: true

module Api
  class ApplicationController < ActionController::Base
    respond_to :json
    include Knock::Authenticable
    before_action :authenticate_user , except: :sign_up
    before_action :skip_session
    # before_action :set_current_user
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::DeleteRestrictionError, with: :render_delete_restriction
    rescue_from ActionController::ParameterMissing, with: :render_missing_params
    rescue_from Pundit::NotAuthorizedError, with: :render_not_authorized
    include Pundit
    protect_from_forgery
  
    def current_user
      if token
        @_current_user ||= begin
          Knock::AuthToken.new(token: token).entity_for(User)
        rescue
          nil
        end
      else
        super
      end
    end

  private

    # JWT: No need to try and load session as there is none in an API request
    def skip_session
      request.session_options[:skip] = true if token
    end

    # JWT: overriding Knock's method to manually trigger Devise's auth.
    # When there is no token we assume the request comes from the browser so
    # has a session (potentially with warden key) attached.
    # def authenticate_entity(entity_name)
    #   if token
    #     super(entity_name)
    #   else
    #     current_user
    #   end
    # end

    def set_current_user
      User.current = current_user
    end

    def render_unprocessable_entity_response(exception)
      render json: { error: exception.record.errors }, status: :unprocessable_entity
    end

    def render_delete_restriction(exception)
      render json: { error: exception.message}, status: :unprocessable_entity
    end

    def render_not_found_response(exception)
      render json: { errors: {error:exception.message} }, status: :not_found
    end

    def render_missing_params(exception)
      render json: { error: exception.message }, status: :unprocessable_entity
    end
    def render_not_authorized(exception)
      render json:{ errors: {error:exception.message} }, status: :unprocessable_entity
    end

  end
end
