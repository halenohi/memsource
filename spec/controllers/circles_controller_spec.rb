require 'rails_helper'

RSpec.describe CirclesController, type: :controller do

  let!(:user) do
      FactoryGirl.create(:user)
  end

  let!(:user2) do
    FactoryGirl.create(:user)
  end

  let!(:circles) do
    FactoryGirl.create_list(:circle,2)
  end

  let!(:membership) do
    FactoryGirl.create(:membership, circle: circles.first, user: user, role: 'owner')
  end

  let!(:other_membership) do
    FactoryGirl.create(:membership, circle: circles.first, user: user2, role: 'member')
  end

  let!(:comment) do
    # commnetするのに必要なcircle_id,user_idを用意
    FactoryGirl.create(:comment, circle: circles.first, user: user)
  end

  before do
    request.env["HTTP_REFERER"] = "back page"
  end

  describe "GET #index" do
    context 'ログインしている場合' do
      it 'ページの取得に成功すること' do
        get :index, session: { user_id: user.id }
        expect(response.status).to eq(200)
        expect(assigns[:circles]).to match_array(circles)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get :index
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "GET #show" do
    context 'ログインしている場合' do
      it 'ページの取得に成功していること' do
        # circleのidとuserのidを用意
        get :show, params: {id: circles.first.id}, session: { user_id: user.id }
        # 成功したら200を返す
        expect(response.status).to eq(200)
        # インスタンス変数のcircleと用意したcircleを比較
        expect(assigns[:circle]).to eq(circles.first)
        # assignsでcontrollerのインスタンス変数@commentsを指定し、eqでspec内で用意したcommentとを比較
        expect(assigns[:comments]).to eq([comment])
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get :show, params: { id: circles.first.id }
        # リダイレクトさせる
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "GET #new" do
    context 'ログインしている場合' do
      it 'ページの取得に成功すること' do
        get :new, session: { user_id: user.id }
        expect(response.status).to eq(200)
        expect(assigns[:circle]).to be_an_instance_of(Circle)
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get :new
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "POST #create" do
    context 'ログインしている場合' do
      context 'paramsがvalidな場合' do
        let(:circle_params) do
          {
            name: 'test circle',
            description: 'test test test test'
          }
        end

        it 'レコードが作成される' do
          expect {
            post :create, params: { circle: circle_params }, session: { user_id: user.id }
            expect(response).to redirect_to(circles_path)
          }.to change(Circle, :count).by(1)
        end
      end

      context 'paramsがinvalidな場合' do
        let(:circle_invalid) do
          {
              name: "",
              description: "tttttttttttttttt"
          }
        end

        it 'レコードが作成されない' do
          expect {
            post :create, params: {circle: circle_invalid }, session: { user_id: user.id }
            expect(response).to render_template(:new)
          }.not_to change(Circle, :count)
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        post :create, params: { id: circles.first.id }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "GET #edit" do
    context 'ログインしている場合' do
      context 'オーナーの場合' do
        it 'サークルの編集が可能' do
          get :edit, params: { id: circles.first.id }, session: { user_id: user.id }
          # circleのidとuserのidがあった場合、200場に返す
          expect(response.status).to eq(200)
          # レスポンスがtrueなら成功 ↑ と同じ
          expect(response).to be_success
          # assignsでcontrollerのインスタンス変数@circleを指定し、eqでspec内で用意したcircle.firstとを比較
          expect(assigns[:circle]).to eq(circles.first)
        end
      end

      context 'オーナーではない場合' do
        it 'サークルの編集ができないから、リダイレクトされる' do
          # FactoryGirlで用意した値circles.first.idを指定し、user2を指定
          get :edit, params: { id: circles.first.id }, session: { user_id: user2.id}
          expect(response).to redirect_to("back page")
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        get :edit, params: { id: circles.first.id }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "PUT #update" do
    context 'ログインしている場合' do
      context 'オーナーの場合' do
        let(:circle_params) do
          {
            name: "updated name"
          }
        end

        context "パラメータが問題ない場合" do
          it 'サークルの情報変更可能' do
            circles.first.tap do |circle|
              expect {
                put :update, params: { id: circle.id, circle: circle_params }, session: { user_id: user.id}
                expect(assigns[:circle]).to eq(circle)
                # redirect
                expect(response).to redirect_to(circle)
                expect(flash[:notice]).not_to eq(nil)
                circle.reload
              }.to change(circle, :name).to("updated name").from(circle.name)
            end
          end
        end

        context "パラメータが不正な場合" do
          let(:circle_params) do
            {
              name: ""
            }
          end

          it 'レコードが更新されないこと' do
            circles.first.tap do |circle|
              expect {
                put :update, params: { id: circle.id, circle: circle_params }, session: { user_id: user.id }
                expect(assigns[:circle]).to eq(circle)
                # render tempalte edit
                expect(response).to render_template(:edit)
                circle.reload
              }.not_to change(circle, :name)
            end
          end
        end
      end

      context 'オーナーではない場合' do
        it 'サークルの情報変更不可、リダイレクトされる' do
          put :update, params: { id: circles.first.id }, session: { user_id: user2.id}
          expect(response).to redirect_to("back page")
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        put :update, params: { id: circles.first.id }
        expect(response).to redirect_to(login_path)
      end
    end
  end

  describe "delete #destroy" do
    context 'ログインしている場合' do
      context 'オーナーの場合' do
        context 'メンバーがいる場合' do
          it 'サークルが消去不可、リダイレクトされる' do
            expect {
              delete :destroy, params: { id: circles.first.id }, session: { user_id: user.id }
              expect(assigns[:circle]).to eq(circles.first)
              expect(response).to redirect_to('back page')
            }.not_to change(Circle, :count)
          end
        end

        context 'メンバーがいない場合' do
          before do
            other_membership.destroy
          end

          it 'サークル消去可能' do
            expect {
              delete :destroy, params: { id: circles.first.id }, session: { user_id: user.id }
              expect(assigns[:circle]).to eq(circles.first)
              expect(response).to redirect_to(circles_path)
              expect(flash[:notice]).not_to eq(nil)
            }.to change(Circle, :count).by(-1)
          end
        end
      end

      context 'オーナーではない場合' do
        it 'サークルの消去不可、リダイレクトされる' do
          delete :destroy, params: { id: circles.first.id }, session: { user_id: user2.id }
          expect(response).to redirect_to('back page')
        end
      end
    end

    context 'ログインしていない場合' do
      it 'ログインページにリダイレクトされる' do
        put :update, params: { id: circles.first.id }
        expect(response).to redirect_to(login_path)
      end
    end
  end
end
