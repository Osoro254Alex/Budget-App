require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should have_many(:groups).with_foreign_key('author_id') }
    it { should have_many(:expenses).with_foreign_key('author_id') }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }

    it 'is valid with a name and an email' do
      user = User.new(name: 'Test', email: 'test@example.com', password: 'password')
      expect(user).to be_valid
    end

    it 'is invalid without a name' do
      user = User.new(email: 'test@example.com', password: 'password')
      expect(user).to be_invalid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an email' do
      user = User.new(name: 'Test', password: 'password')
      expect(user).to be_invalid
      expect(user.errors[:email]).to include("can't be blank")
    end
  end

  describe 'authentication' do
    user = User.new(name: 'Test', password: 'password')

    it 'should authenticate a valid user' do
      expect(user.valid_password?('password')).to be(true)
    end

    it 'should not authenticate an invalid user' do
      expect(user.valid_password?('wrong_password')).to be(false)
    end
  end

  describe 'associations' do
    it 'has many groups' do
      user = User.create(name: 'Test', email: 'test@example.com', password: 'password')
      group1 = Group.create(name: 'Test1', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      group2 = Group.create(name: 'Test2', icon: fixture_file_upload('icon.png', 'image/png'), author: user)
      expect(user.groups).to eq([group1, group2])
    end

    it 'has many expenses' do
      user = User.create(name: 'Test', email: 'test@example.com', password: 'password')
      expense1 = Expense.create(name: 'Test1', amount: 10, author: user)
      expense2 = Expense.create(name: 'Test2', amount: 20, author: user)
      expect(user.expenses).to eq([expense1, expense2])
    end
  end
end
