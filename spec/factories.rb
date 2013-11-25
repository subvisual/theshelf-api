FactoryGirl.define do
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

  factory :book, aliases: [:available_book] do
    sequence(:title) { |n| "#{n}Book" }
    authors 'John Doe'

    factory :lent_book do
      ignore do
        borrower nil
      end

      after(:create) do |book, evaluator|
        book.lend_to! borrower: evaluator.borrower
      end
    end
  end
end
