FactoryBot.define do
  factory :email_config do
    subject { "MyString" }
    body { "MyText" }
    from_email { "MyString" }
    hub { nil }
  end
end
