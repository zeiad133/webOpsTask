class Api::UsersController < Api::ApplicationController
  

  def sign_up
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: :created
    else
      render json: {errors: @user.errors}, status: :unprocessable_entity 
    end
  end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :name , :image)
    end
end
