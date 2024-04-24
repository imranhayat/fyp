class LearnersController < ApplicationController
  before_action :authenticate_user!

  def searchlocation
    @schools = User.search(params[:search])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def createbooking
    @booking = Booking.build(booking_params)
    @booking.customer_id = current_user.id
    if @booking.save
      redirect_to request.referer, notice: "Booking created successfully"
    else
      redirect_to request.referer, alert: @booking.errors.full_messages.join
    end
  end

  def allbookings
    if current_user.user?
      @bookings = current_user.bookings
    elsif current_user.school?
      @bookings = current_user.school_bookings
    end
    respond_to do |format|
      format.js
      format.html
    end
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:school_id, :lesson_id)
    end
end