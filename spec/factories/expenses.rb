FactoryBot.define do
  factory :expense do
    name { 'mac donals' }
    amount { 17.00 }
    author { association :user }
  end
end
