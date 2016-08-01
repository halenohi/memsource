require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe "GET #new" do
    context 'success' do
      it "returns http success" do
        expect {
          get :new
          expect(response).to have_httpstatus(:success)
        }
      end
    end
  end

  let!(:user) do
    FactoryGirl.create(:user)
  end

  let!(:user2) do
    FactoryGirl.create(:user)
  end

  let!(:users) do
    FactoryGirl.create_list(:user,2)
  end

  let!(:valid_params) do
    {
      email: 'user@email',
      password: 'user.password'
    }
  end

  let!(:invalid_email_params) do
    {
      email: 'user.email',
      password: ''
    }
  end

  let!(:invalid_password_params) do
    {
      email: '',
      password: 'user.password'
    }
  end

  describe "POST #create" do
    context 'success' do
      it "should post user email & password" do
        post :create, valid_params.tapp
        expect (response).to redirect_to(root_path)
        expect (request.session[:user_id]).to eq(user.id)
      end
    end

    context 'post email only' do
      xit "should post user email" do
        post :create, (invalid_email_params).tapp
        expect(response).to render_tampate(:new)
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
      let(:user_params) do
        {
            email: "test@test.com",
            password: "testestetstestest"
        }
      end

      it 'should delete session' do
        expect(controller.session).to receive(:delete).with(:user_id)
        delete :destroy, session: { user_id: user.id }
        expect(flash[:notice]).not_to eq(nil)
        expect(response).to redirect_to login_path
      end
    end

    context 'failure' do
      it 'should not delete session' do
        expect {
          get :destroy, params: { id: user.id }, session: { user_id: user2.id }
          expect(response).to redirect_to login_path
        }.not_to change(User, :count)
      end
    end
  end

end
