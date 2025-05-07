FactoryBot.define do
  factory :activity do
    action { "MyString" }
    user { nil }
    hub { nil }
    trackaable { nil }
    data { "" }
  end
end
