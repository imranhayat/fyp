class CreateLessons < ActiveRecord::Migration[7.1]
  def change

    create_table :lessons do |t|
      t.string :title, default: ""
      t.text :description, default: ""
      t.belongs_to :school, null: false, foreign_key: { to_table: :users }
      t.references :instructor, foreign_key: { to_table: :users }, index: true
      t.timestamps
    end

    create_table :bookings do |t|
      t.integer :status, default: 0
      t.references :customer, foreign_key: { to_table: :users }, index: true
      t.references :school, foreign_key: { to_table: :users }, index: true
      t.timestamps
    end
  end
end