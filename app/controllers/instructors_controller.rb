class InstructorsController < ApplicationController
  before_action :authenticate_user!

  def allbookings
    if current_user.instructor?
      @bookings = current_user.taught_lessons.flat_map { |lesson| lesson.bookings }
    end
    respond_to do |format|
      format.js
      format.html
    end
  end
  
end