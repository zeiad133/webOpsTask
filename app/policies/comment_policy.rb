class CommentPolicy < ApplicationPolicy
    attr_reader :user, :comment
  
    def initialize(user, comment)
      @user = user
      @comment = comment
    end
  

    def update?
        @comment.user.id == @user.id  ? true : (raise Pundit::NotAuthorizedError, "You are not allowed to do this function")
    end

    def destroy?
        @comment.user.id == @user.id  ? true : (raise Pundit::NotAuthorizedError, "You are not allowed to do this function")
    end
  
  end
  