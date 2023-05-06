require 'rails_helper'

RSpec.describe GroupExpense, type: :model do
  describe 'associations' do
    it { should belong_to(:group) }
    it { should belong_to(:expense) }
  end
end
