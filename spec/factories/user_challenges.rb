FactoryBot.define do
  factory :user_challenge do
    user { nil }
    challenge { nil }
    completed { false }
    points_awarded { 1 }
  end
end
