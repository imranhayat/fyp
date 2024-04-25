class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :instructor, :school, :admin]
  enum vehicle_type: [:bike, :car]

  validates :email, uniqueness: true, format: { with: /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/, message: "is invalid format" }
  validates :username, uniqueness: true
  
  has_one_attached :picture, dependent: :destroy
  has_one_attached :fitness_certificate, dependent: :destroy
  has_many :taught_lessons, class_name: "Lesson", foreign_key: "instructor_id", dependent: :destroy
  has_many :school_lessons, class_name: "Lesson", foreign_key: "school_id", dependent: :destroy

  has_many :bookings, class_name: "Booking", foreign_key: "customer_id", dependent: :destroy # customer bookings
  has_many :school_bookings, class_name: "Booking", foreign_key: "school_id", dependent: :destroy # school all bookings

  before_create :set_username!
  before_create :set_first_name_and_last_name, if: proc { |obj| obj.school? }
  before_create :set_approved!

  default_scope { order(created_at: :desc) }

  attr_accessor :user_account, :name

  # search for schools by customer
  def self.search(query)
    if query.present?
      where("
        address ILIKE?", 
        "%#{query}%"
      ).limit(10)
    else
      all
    end
  end

  def set_first_name_and_last_name
    split_name = name.split(" ")
    self.first_name = split_name[0].join(" ")
    self.last_name = split_name[1..].join(" ")
  end

  def full_name
    first_name.to_s + last_name.to_s
  end

  private

    def set_username!
      self.username = email.split("@")[0]
    end

    def set_approved!
      self.approved = true if self.role == "school"
    end

end
