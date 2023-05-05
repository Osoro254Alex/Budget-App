require 'rails_helper'

RSpec.describe 'groups/new.html.erb', type: :feature do
  let(:user) { FactoryBot.create(:user) }

  it 'creates a new group with a valid name and icon' do
    category = Group.new
    icon_path = Rails.root.join('spec', 'fixtures', 'files', 'icon.png')
    file = Rack::Test::UploadedFile.new(icon_path, 'image/png')
    category.icon = file
    category.name = 'Test Group'
    category.author = user
    expect do
      category.save
    end.to change(Group, :count).by(1)
    expect(category.name).to eq('Test Group')
    expect(category.icon.attached?).to eq(true)
  end

  it 'does not create a new group without a name' do
    category = Group.new
    icon_path = Rails.root.join('spec', 'fixtures', 'files', 'icon.png')
    file = Rack::Test::UploadedFile.new(icon_path, 'image/png')
    category.icon = file
    expect do
      category.save
    end.not_to change(Group, :count)
    expect(category.errors[:name]).to include("can't be blank")
  end

  it 'does not create a new group without an icon' do
    category = Group.new(name: 'Test Group')
    expect do
      category.save
    end.not_to change(Group, :count)
    expect(category.errors[:icon]).to include("can't be blank")
  end
end
