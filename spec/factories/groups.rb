FactoryBot.define do
  factory :group do
    name { 'foods' }
    icon { nil }
    author { association :user }
  end
end
