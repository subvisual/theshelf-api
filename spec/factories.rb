FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "Book #{n}" }
    authors 'John Doe'
  end
end
