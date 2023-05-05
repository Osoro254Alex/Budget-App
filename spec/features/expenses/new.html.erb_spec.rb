require 'rails_helper'

RSpec.describe 'expenses/new.html.erb', type: :feature do
  let!(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let!(:group) { Group.create(name: 'Test1', icon: fixture_file_upload('icon.png', 'image/png'), author: user) }
  let!(:expense) { Expense.new(name: 'Test', amount: 10, author: user) }
  let!(:group_expense) { GroupExpense.create(group:, expense:) }

  it 'does not create a new expense without a name' do
    expense = Expense.new(amount: 10)
    expect do
      expense.save
    end.not_to change(Expense, :count)
    expect(expense.errors[:name]).to include("can't be blank")
  end

  it 'does not create a new expense without an amount' do
    expense = Expense.new(name: 'Test expense')
    expect do
      expense.save
    end.not_to change(Expense, :count)
    expect(expense.errors[:amount]).to include("can't be blank")
  end
end
