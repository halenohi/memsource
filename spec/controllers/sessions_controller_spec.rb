require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    xit "returns http success" do
      get :new
      expect(response).to have_httpstatus(:success)
    end
  end

  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:valid_params) do
    {
      email: user.email,
      password: user.password
    }
  end

  let!(:invalid_email_params) do
    {
      email: user.email,
      password: ''
    }
  end

  let!(:invalid_password_params) do
    {
      email: '',
      password: user.password
    }
  end

  describe "POST #create" do
    context 'success' do
      it "should post user email & password" do
        post :create, valid_params
        expect(response).to redirect_to(root_path)
        expect(request.session[:user_id]).to eq(user.id)
      end
    end

    context 'post email only' do
      it "should post user email" do
        post :create, (invalid_email_params).tapp
      end
    end

    context 'post password only' do
      xit "should post user password" do
        expect {
          post :create, user: invalid_password_params
          expect(response).to render_template(:new)
        }.to change{User.count}.by(0)
      end
    end
  end

  describe "GET #destroy" do
    context 'succes' do
      xit 'should delete account' do
        expect (ressponse).to change{User.count}.by(-1)
      end
    end
  end

end
