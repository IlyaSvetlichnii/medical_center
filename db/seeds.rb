# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

doctor =
  User.create(
    birthday: DateTime.now,
    first_name: "Doctor",
    last_name: "W.",
    patronymic: "Walentime",
    email: "doctor@gmail.com",
    password: "password",
    password_confirmation: "password",
    doctor_id: nil,
    position: :doctor
  )

user_list = [
  [ "James", "F.", "Thomas", "user1@gmail.com" ],
  [ "Danny", "G.", "Olson", "user2@gmail.com" ],
  [ "Kevin", "J.", "Kindred", "user3@gmail.com" ],
  [ "Carolyn", "R.", "McNamara", "user4@gmail.com" ]
]

user_list.each do |name, last_name, patronymic, email|
  User.create(
    birthday: DateTime.now,
    first_name: name,
    last_name: last_name,
    patronymic: patronymic,
    email: email,
    password: "password",
    password_confirmation: "password",
    doctor_id: doctor.id,
    position: :patient
  )
end