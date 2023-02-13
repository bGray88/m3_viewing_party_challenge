FactoryBot.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {Faker::Food.dish}
  end
end
