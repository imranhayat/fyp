class AddLessonToBooking < ActiveRecord::Migration[7.1]
  def change
    add_reference :bookings, :lesson, foreign_key: true
  end
end
