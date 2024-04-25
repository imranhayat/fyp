class Booking < ApplicationRecord

  belongs_to :lesson
  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  belongs_to :school, class_name: "User", foreign_key: "school_id"

  enum status: [:draft, :confirmed, :completed, :cancelled]

  def is_review_exist?
    Review.find_by_booking_id(id).present?
  end
  
end