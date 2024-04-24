class Lesson < ApplicationRecord

  belongs_to :school, class_name: "User", foreign_key: "school_id"
  belongs_to :instructor, class_name: "User", foreign_key: "instructor_id", optional: true
  has_many :bookings, dependent: :destroy

end