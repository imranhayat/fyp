class UserController < ApplicationController
  before_action :authenticate_user!
  # before_action :find_user, only: [:update]

  def update
    if current_user.update(user_params)
      redirect_to request.referer, notice: "Profile updated successfully"
    else
        redirect_to request.referer, alert: @user.errors.full_messages.join
    end
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :username, :phone_number,:address,:picture,:fitness_certificate)
    end
end