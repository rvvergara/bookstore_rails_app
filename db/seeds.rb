# frozen_string_literal: true

34.times do |n|
  User.create(
    username: "user-#{n}",
    email: "user#{n}@gmail.com",
    password: 'password',
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  )
end
