MOVIES = ["Kill Bill", "Django", "Kill Bill 2"]

FactoryBot.define do
  factory :movie do
    title { MOVIES.sample}
    description { Faker::Lorem.sentence(3, true) }
    released_at { Faker::Date.between(40.years.ago, Time.zone.today) }
    genre
  end
end
