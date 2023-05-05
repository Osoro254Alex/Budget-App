FactoryBot.define do
  factory :group_expense do
    category { association :group }
    expense { association :expense }
  end
end
