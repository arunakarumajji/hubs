FactoryBot.define do
  factory :admin do
    email { "MyString" }
    password_digest { "MyString" }
    first_name { "MyString" }
    last_name { "MyString" }
    hub { nil }
  end
end
