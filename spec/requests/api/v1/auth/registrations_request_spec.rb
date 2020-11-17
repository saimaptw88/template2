require "rails_helper"

RSpec.describe "Api::V1::Auth::Registrations", type: :request do
  describe "POST api/v1/auth/registrations #create" do
    subject { post(api_v1_user_registration_path, params: params) }

    let(:res) { JSON.parse(response.body) }

    context "正常な値を送信した場合" do
      let(:params) { attributes_for(:user) }

      it "レスポンスが正常" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "新規登録に成功する" do
        expect { subject }.to change { User.count }.by(1)
      end

      it "nameが登録される" do
        subject
        expect(res["data"]["name"]).to eq params[:name]
      end

      it "emailが登録される" do
        subject
        expect(res["data"]["email"]).to eq params[:email]
      end
    end

    context "正常でない値を送信した場合" do
      context "passwordが空の場合" do
        let(:params) { { name: "saito", email: "saito@sample.com" } }

        it "登録に失敗する" do
          subject
          expect(res["errors"]["password"]).to eq ["can't be blank"]
        end
      end

      context "emailが空の場合" do
        let(:params) { { name: "saito", password: "123456" } }

        it "登録に失敗する" do
          subject
          expect(res["errors"]["email"]).to eq ["can't be blank"]
        end
      end
    end
  end
end
