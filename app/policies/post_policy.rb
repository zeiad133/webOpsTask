class PostPolicy < ApplicationPolicy
    attr_reader :user, :post
  
    def initialize(user, post)
      @user = user
      @post = post
    end 
  
    def update?
        @post.user.id == @user.id  ? true : (raise Pundit::NotAuthorizedError, "You are not allowed to do this function")
    end

    def destroy?
        @post.user.id == @user.id  ? true : (raise Pundit::NotAuthorizedError, "You are not allowed to do this function")
    end
  
  end
  