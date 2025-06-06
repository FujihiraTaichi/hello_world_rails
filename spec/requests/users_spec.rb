require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    subject { get(users_path)}
    before { create_list(:user, 3) }

   it "ユーザーの一覧が取得できる" do

      subject
      # binding.pry
      res = JSON.parse(response.body)
      expect(res.length).to eq 3
      expect(res[0].keys).to eq ["account", "name", "email"]
      expect(response).to have_http_status(200)
      # get users_path
    end
  end

  describe "GET /users/:id" do
    subject { get(user_path(user_id) )}
    context "指定したidのユーザーが存在しているとき" do
      let(:user_id) { user.id }
      let(:user) { create(:user) }

     it "そのユーザーのレコードが取得できる" do
      subject
      # binding.pry

      res = JSON.parse(response.body)
      expect(res["name"]).to eq user.name
      expect(res["account"]).to eq user.account
      expect(res["email"]).to eq user.email

      expect(response).to have_http_status(200)
     end
   end

    context "指定したidのユーザーが存在しないとき" do
      let(:user_id){ 10000 }
      it "ユーザーが見つからない" do
        # binding.pry
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
 end

  describe "GET /users/:id" do
    it "任意のユーザーのレコードが取得できる" do
    end
  end

  describe "POST /users" do
    subject { post(users_path, params: params) }

   context "適切なパラメーターを送信したとき" do
     let(:params) do
       {user: attributes_for(:user) }
     end
     it "ユーザーのレコードが作成できる" do
       expect { subject }.to change { User.count }.by(1)
        # binding.pry
        res = JSON.parse(response.body)
        expect(res["name"]).to eq params[:user][:name]
        expect(res["account"]).to eq params[:user][:account]
        expect(res["email"]).to eq params[:user][:email]

        expect(response).to have_http_status(200)
      end
   end

   context "不適切な送信したパラメーターを送信したとき" do
     let(:params)  { attributes_for(:user) }

     it "エラーする" do
       #  binding.pry
       expect { subject }.to raise_error(ActionController::ParameterMissing)
     end
    end
  end

  describe "PATCH /users/:id" do
    subject { patch(user_path(user_id), params: params)}

    let(:params) do
        { user: { name: Faker::Name.name, created_at: 1.day.ago } }
    end
    let(:user_id) { user.id }
    let(:user) { create(:user) }

    it "任意のユーザーのレコードを更新できる" do
      expect { subject }.to change { user.reload.name }.from(user.name).to(params[:user][:name])
      expect { subject }.to not_change { user.reload.account }
      expect { subject }.to not_change { user.reload.email }
      expect { subject }.to not_change { user.reload.created_at }

    end

  end

  describe "DELETE /users/:id" do
    subject { delete(user_path(user_id)) }
    let(:user_id) { user.id }
    let!(:user) { create(:user) }

    it "任意のユーザーのレコードを削除できる" do
     expect { subject }.to change { User.count }.by(-1)

    end
  end
end
  # describe "GET /users" do
  #   it "works! (now write some real specs)" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end

  # describe "ユーザーの一覧を表示" do
  #   it "ユーザーの一覧を取得する" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  # describe "ユーザーの詳細を表示する" do
  #   it "ユーザーの詳細を表示する" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  # describe "ユーザーを作成し保存する" do
  #   it "ユーザーを作成し保存する" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  # describe "ユーザーの情報を更新する" do
  #   it "ユーザーの情報を更新する" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
  # describe "ユーザーの情報を削除する" do
  #   it "ユーザーの情報を削除する" do
  #     get users_path
  #     expect(response).to have_http_status(200)
  #   end
  # end
