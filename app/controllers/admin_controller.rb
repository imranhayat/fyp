class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: [:approve_user, :reject_user]

  def approve_user
    @user.update!(approved: true)
    BasicMailer.confirmation_email(@user).deliver
    redirect_to request.referrer
  end

  def reject_user
    @user.update!(approved: false)
    redirect_to request.referrer
  end

  def allusers
    @users = User.all - [current_user]
  end

  private

    def find_user
      @user = User.find(params[:id])
    end
end