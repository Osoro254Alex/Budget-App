require 'rails_helper'

RSpec.describe 'groups/index.html.erb', type: :feature do
  let!(:user) { User.create(name: 'test', email: 'test@example.com', password: 'password') }
  let!(:group) { Group.create(name: 'Test1', icon: fixture_file_upload('icon.png', 'image/png'), author: user) }
  let!(:expense) { Expense.create(name: 'Test', amount: 10, author: user) }
  let!(:group_expense) { GroupExpense.create(group:, expense:) }

  before do
    sign_in user
    visit groups_path
  end

  it 'displays all categories' do
    expect(page).to have_content(group.name)
    expect(page).to have_content('CATEGORIES')
    expect(page).to have_content(number_to_currency(group.total_amount).to_s)
  end

  it 'should show the picture for each category' do
    expect(page).to have_css('img')
  end

  it 'contains links' do
    expect(page).to have_link group.name
    expect(page).to have_link 'Add New Category'
  end

  it 'redirects to category payments page when clicking on a category' do
    click_link group.name
    expect(page).to have_current_path(group_expenses_path(group))
  end

  it 'redirects to new category form when clicking on "Add new category" button' do
    click_link 'Add New Category'
    expect(page).to have_current_path(new_group_path)
  end
end
