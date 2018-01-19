FactoryBot.define do
  factory :device do
    name { Faker::Lorem.word }
    description { Faker::Simpsons.quote }
    secret "MyText"
    MAC { Faker::Number.number(10) }
    private false
    trash false
    created_by nil
  end
end
