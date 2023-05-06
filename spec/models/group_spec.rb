require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:icon) }
    it { should belong_to(:author) }
    it { should have_many(:expenses) }
    it 'is valid with a name and an icon' do
      group = Group.new(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expect(group).to be_valid
    end
    it 'is invalid without a name' do
      group = Group.new(icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expect(group).to be_invalid
      expect(group.errors[:name]).to include("can't be blank")
    end
    it 'is invalid without an icon' do
      group = Group.new(name: 'Test', author: user)
      expect(group).to be_invalid
      expect(group.errors[:icon]).to include("can't be blank")
    end
  end

  describe 'associations' do
    it 'belongs to an author' do
      group = Group.new(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expect(group.author).to eq(user)
    end
    it 'has many expenses' do
      expense1 = Expense.create(name: 'text expense 1', amount: 10, author: user)
      expense2 = Expense.create(name: 'text expense 2', amount: 20, author: user)
      expect(user.expenses).to eq([expense1, expense2])
    end
  end

  describe '#total_amount' do
    it 'returns the sum of expenses amount for the group' do
      group = Group.create(name: 'Test', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expense1 = Expense.create(name: 'text expense 1', amount: 10, author: user)
      GroupExpense.create(group:, expense: expense1)
      expense2 = Expense.create(name: 'text expense 2', amount: 20, author: user)
      GroupExpense.create(group:, expense: expense2)
      expect(group.total_amount).to eq(30)
    end
  end
end
