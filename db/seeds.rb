# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
User.create!(name: "Man Yu", email: "yuman@outlook.com", password: "101209", password_confirmation: "101209", admin:true, activated: true, activated_at: Time.zone.now)

99.times do |n|
  name = Faker::Name.name
  email = "test_user#{n}@microhard.com"
  password = "qwerasdf"
  User.create!(name: name, email: email, password: password, password_confirmation: password, activated: true, activated_at: Time.zone.now)
end

Project.create(name: "sample", user_id: User.find_by(email: "yuman@outlook.com").id)
Project.create(name: "sample1", user_id: User.find_by(email: "yuman@outlook.com").id)

User.all.each do |user|
  user.create_home
end


