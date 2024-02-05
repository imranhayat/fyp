# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    login_param = params[:user][:user_account]
    user = if login_param.include?('@') # Check if the input contains '@', assuming it's an email
             User.find_for_database_authentication(email: login_param)
           else
             User.find_for_database_authentication(username: login_param)
           end

    if user && user.valid_password?(params[:user][:password])
      sign_in(user)
      redirect_to root_path # Customize the redirect path as needed
    else
      flash.now[:alert] = 'Invalid email/username or password'
      render :new
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
