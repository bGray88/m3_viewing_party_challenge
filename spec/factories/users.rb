FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email  { Faker::Internet.email }
    password { Faker::Food.dish }
    traits_for_enum :role, { default: 0, admin: 1, manager: 2 }
  end
end
