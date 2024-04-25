class Review < ApplicationRecord

  belongs_to :customer, class_name: "User", foreign_key: "customer_id"
  belongs_to :school, class_name: "User", foreign_key: "school_id"
  belongs_to :lesson

end