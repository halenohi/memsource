require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "GET #new" do
    xit "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  # modelで作っておいたFactoryGirlを使用
  let!(:user) do
    FactoryGirl.create(:user)
  end

  let(:valid_params) do
    {
      name: 'test',
      email: 'sample@example.com',
      password: 'gdeeiug42i5389v8wh3iu',
      password_confirmation: 'gdeeiug42i5389v8wh3iu'
    }
  end

  let(:invalid_params) do
    {
      email: '',
      password: '',
      password_confirmation: 'sefeewfew'
    }
  end

  describe "POST #create" do
    context 'succes' do
      it 'should create user record' do
        expect {
          post :create, user: valid_params
          expect(response).to redirect_to(root_path)
        }.to change{User.count}.by(1)
      end
    end

    context 'fail' do
      it 'should not create user record' do
        expect {
          post :create, user: invalid_params
          expect(response).to render_template(:new)
        }.to change{User.count}.by(0)
      end
    end
  end

  describe "GET #destroy" do
    xit "returns http success" do
      get :destroy
      expect(response).to have_http_status(:success)
    end
  end

end
