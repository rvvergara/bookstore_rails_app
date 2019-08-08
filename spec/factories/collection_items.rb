FactoryBot.define do
  factory :collection_item do
    association :user
    association :book
    current_page { 0 }
  end
end
