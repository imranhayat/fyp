class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]

  validates :email, uniqueness: true, format: { with: /[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/, message: "is invalid format" }
  validates :username, uniqueness: true

  before_create :set_username!

  attr_accessor :user_account

  private

    def set_username!
      self.username = email.split("@")[0]
    end
end
