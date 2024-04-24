class SchoolsController < ApplicationController
  before_action :authenticate_user!

  def alllessons
    @lessons = Lesson.all
    respond_to do |format|
      format.js
      format.html
    end
  end

  def createlesson
    @lesson = Lesson.create(lesson_params)
    if @lesson.persisted?
        redirect_to request.referer, notice: "Lesson created successfully"
    else
        redirect_to request.referer, alert: @lesson.errors.full_messages.join
    end
  end

  def allinstructors
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

    def lesson_params
      params.require(:lesson).permit(:title, :description, :school_id, :instructor_id)
    end

end