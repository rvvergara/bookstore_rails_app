FactoryBot.define do
  factory :user do
    username { Faker::Lorem.sentence(1) }
    email { Faker::Internet.email }
    password { 'password' }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end

  factory :invalid_user, class: 'User' do
    username { Faker::Lorem.sentence(1) }
    email { Faker::Internet.email }
    password { 'password' }
    first_name { nil }
    last_name { Faker::Name.last_name }
  end
end
