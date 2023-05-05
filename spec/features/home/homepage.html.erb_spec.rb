require 'rails_helper'

RSpec.describe 'home/homepage.html.erb', type: :feature do
  before do
    visit root_path
  end

  it 'renders successfully' do
    expect(page).to have_content('BudgetApp')
    expect(page).to have_content('Log In')
    expect(page).to have_content('Sign Up')
  end

  it 'contains Log In and Sign Up links' do
    expect(page).to have_link 'Log In'
    expect(page).to have_link 'Sign Up'
  end

  it 'redirects to the log in page' do
    click_link 'Log In'
    expect(page).to have_current_path(new_user_session_path)
  end

  it 'redirects to the sign up page' do
    click_link 'Sign Up'
    expect(page).to have_current_path(new_user_registration_path)
  end
end
