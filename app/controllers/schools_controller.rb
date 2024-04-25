class SchoolsController < ApplicationController
  before_action :authenticate_user!

  def alllessons
    @lessons = current_user.school_lessons
    respond_to do |format|
      format.js
      format.html
    end
  end

  def createlesson
    @lesson = Lesson.build(title: params[:title], description: params[:description], instructor_id: params[:instructor_id])
    @lesson.school_id = current_user.id
    if @lesson.save!
        redirect_to request.referer, notice: "Lesson created successfully"
    else
        redirect_to request.referer, alert: @lesson.errors.full_messages.join
    end
  end

  def edit_lesson
    find_lesson
    if @lesson.update!(title: params[:title], description: params[:description], instructor_id: params[:instructor_id])
      redirect_to request.referer, notice: "Lesson updated successfully"
    else
      redirect_to request.referer, alert: @lesson.errors.full_messages.join
    end
  end

  def delete_lesson
    find_lesson
    if @lesson.destroy
      redirect_to request.referer, notice: "Lesson deleted successfully"
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

    def find_lesson
      @lesson = current_user.school_lessons.find(params[:lesson_id])
    end

    # def lesson_params
    #   params.require(:lesson).permit(:title, :description, :school_id, :instructor_id)
    # end

end