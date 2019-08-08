FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    subtitle { Faker::Lorem.sentence(5) }
    description { Faker::Lorem.paragraph(3) }
    published_date { '2019-07-15' }
    page_count { Faker::Number.within(5..20) }
    thumbnail { 'http://example.org' }
    authors { Faker::Name.name }
    isbn { Faker::Number.number(13) }
    category { 'Action' }
  end
end
