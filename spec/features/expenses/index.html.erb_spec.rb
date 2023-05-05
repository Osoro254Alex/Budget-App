require 'rails_helper'

RSpec.describe 'expenses/index.html.erb', type: :feature do
  let!(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let!(:group) { Group.create(name: 'Test1', icon: fixture_file_upload('icon.png', 'image/png'), author: user) }
  let!(:expense) { Expense.new(name: 'Test', amount: 10, author: user) }
  let!(:group_expense) { GroupExpense.create(group:, expense:) }
  before do
    sign_in user
    visit group_expenses_path(group)
  end

  it 'displays the group name and total amount' do
    expect(page).to have_content(group.name)
    expect(page).to have_content(number_to_currency(group.total_amount).to_s)
  end

  it 'contains links' do
    expect(page).to have_link 'Add New Transaction'
  end

  it 'takes you to the new expense page' do
    click_link 'Add New Transaction'
    expect(page).to have_current_path(new_group_expense_path(group))
  end

  it 'displays the correct expenses for the group' do
    expect(page).to have_content(expense.name)
    expect(page).to have_content('TRANSACTIONS')
  end
end
