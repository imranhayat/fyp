class CreateReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :reviews do |t|
      t.integer :rating, default: 0
      t.string :feedback
      t.integer :booking_id, null: false
      t.references :customer, foreign_key: { to_table: :users }, index: true
      t.references :school, foreign_key: { to_table: :users }, index: true
      t.references :lesson, foreign_key: true, index: true
      t.timestamps
    end
  end
end
