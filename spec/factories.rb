FactoryGirl.define do
  factory :book do
    sequence(:title) { |n| "Book #{n}" }
    authors 'John Doe'
  end

  factory :user do
    sequence(:email) { |n| "user#{n}@gmail.com" }
    sequence(:first_name) { |n| "Mc#{n}" }
    sequence(:last_name ) { |n| "Donalds#{n}" }
    password 'password'

    factory :admin do
      after(:build) do |user|
        user.make_admin
      end
    end
  end
end
