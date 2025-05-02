FactoryBot.define do
  factory :challenge do
    title { "MyString" }
    description { "MyText" }
    sharing_link { "MyString" }
    points { 1 }
    hub { nil }
  end
end
