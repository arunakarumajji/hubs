FactoryBot.define do
  factory :user do
    email { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    hub { nil }
    status { 1 }
  end
end
