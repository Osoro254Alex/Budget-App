require 'rails_helper'

RSpec.describe GroupsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:group1) { FactoryBot.create(:group, author: user) }
  let(:group2) { FactoryBot.create(:group, author: user) }

  before do
    user.save
    sign_in user
  end

  describe 'GET #index' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns @groups with user groups' do
      get :index
      expect(assigns(:groups)).to eq(user.groups)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new group to @group' do
      get :new
      expect(assigns(:group)).to be_a_new(Group)
    end
  end
end
