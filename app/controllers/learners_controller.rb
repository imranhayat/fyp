class LearnersController < ApplicationController
  before_action :authenticate_user!

  def searchlocation
    @schools = User.school.search(params[:search]) if params[:search].present?
    @is_searchable = params[:search].present?
    respond_to do |format|
      format.js
      format.html
    end
  end

  def createbooking
    @booking = Booking.build(lesson_id: params[:lesson_id], school_id: params[:school_id])
    @booking.customer_id = current_user.id
    if @booking.save
      redirect_to request.referer, notice: "Booking created successfully"
    else
      redirect_to request.referer, alert: @booking.errors.full_messages.join
    end
  end

  def update_booking_status
    find_booking
    @booking.update!(status: params[:status])
    redirect_to request.referrer
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

  def add_review
    if current_user.user?
      find_lesson
      @review = @lesson.reviews.build(rating: params[:rating], feedback: params[:feedback], booking_id: params[:booking_id], customer_id: current_user.id, school_id: params[:school_id])
      if @review.save!
        redirect_to request.referer, notice: "Thank you for your review."
      else
        redirect_to request.referer, alert: @review.errors.full_messages.join
      end
    else
      redirect_to request.referer, alert: "You can not perform this action!"
    end
  end

  private

    def find_user
      @user = User.find(params[:id])
    end

    def find_booking
      @booking = Booking.find(params[:id])
    end

    def find_lesson
      @lesson = Lesson.find(params[:lesson_id])
    end

    # def booking_params
    #   params.require(:booking).permit(:school_id, :lesson_id)
    # end
end