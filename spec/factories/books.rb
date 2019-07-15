FactoryBot.define do
  factory :book do
    title { "MyString" }
    subtitle { "MyString" }
    description { "MyText" }
    published_date { "2019-07-15" }
    page_count { 1 }
    thumbnail { "MyString" }
    authors { "MyString" }
    isbn { "MyString" }
    category { "" }
  end
end
