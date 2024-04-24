# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

admin = User.create(
  username: "admin",
  email: "admin@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  role: "admin",
  approved: true
)

puts "*** Admin with email: #{admin.email} created! ***"; puts

school = User.create(
  username: "school",
  email: "school@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  role: "school",
  approved: true
)

user = User.create(
  username: "user",
  email: "user@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  role: "user",
  approved: true
)

instructor = User.create(
  username: "instructor",
  email: "instructor@test.com",
  password: "admin123",
  password_confirmation: "admin123", 
  role: "instructor",
  approved: true
)

lesson = Lesson.create(
  title: "abc",
  description: "aaa",
  school_id: school.id,
  instructor_id: instructor.id
)

lesson2 = Lesson.create(
  title: "abc 2",
  description: "aaa",
  school_id: school.id,
  instructor_id: instructor.id
)

booking = Booking.create(
  customer_id: user.id,
  school_id: school.id,
  lesson_id: lesson.id
)