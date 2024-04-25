# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_25_095048) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "bookings", force: :cascade do |t|
    t.integer "status", default: 0
    t.bigint "customer_id"
    t.bigint "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "lesson_id"
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
    t.index ["lesson_id"], name: "index_bookings_on_lesson_id"
    t.index ["school_id"], name: "index_bookings_on_school_id"
  end

  create_table "lessons", force: :cascade do |t|
    t.string "title", default: ""
    t.text "description", default: ""
    t.bigint "school_id", null: false
    t.bigint "instructor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instructor_id"], name: "index_lessons_on_instructor_id"
    t.index ["school_id"], name: "index_lessons_on_school_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", default: 0
    t.string "feedback"
    t.integer "booking_id", null: false
    t.bigint "customer_id"
    t.bigint "school_id"
    t.bigint "lesson_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_reviews_on_customer_id"
    t.index ["lesson_id"], name: "index_reviews_on_lesson_id"
    t.index ["school_id"], name: "index_reviews_on_school_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "username", default: "", null: false
    t.string "phone_number"
    t.string "address"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "vehicle_type", default: 0
    t.boolean "approved", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bookings", "lessons"
  add_foreign_key "bookings", "users", column: "customer_id"
  add_foreign_key "bookings", "users", column: "school_id"
  add_foreign_key "lessons", "users", column: "instructor_id"
  add_foreign_key "lessons", "users", column: "school_id"
  add_foreign_key "reviews", "lessons"
  add_foreign_key "reviews", "users", column: "customer_id"
  add_foreign_key "reviews", "users", column: "school_id"
end
