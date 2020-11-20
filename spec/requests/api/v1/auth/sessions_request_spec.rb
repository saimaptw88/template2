require "rails_helper"

RSpec.describe "Api::V1::Auth::Sessions", type: :request do
  describe "POST   /api/v1/auth/sign_in" do
    subject { post(api_v1_user_session_path, params: params) }

    let(:user) { create(:user) }
    let(:res) { JSON.parse(response.body) }

    context "送信した値が正常な場合" do
      let(:params) { attributes_for(:user, name: nil, email: user.email, password: user.password) }

      it "レスポンスが正常" do
        subject
        expect(response).to have_http_status :ok
      end
    end

    context "送信した値が正常でない場合" do
      context "emailが空の場合" do
        let(:params) { attributes_for(:user, email: nil) }

        it "エラーする" do
          expect { subject }.to raise_error(NoMethodError)
        end
      end

      context "passwordが空の場合" do
        let(:params) { attributes_for(:user, name: nil, email: user.email, password: nil) }

        it "エラーする" do
          subject
          expect(res["errors"]).to eq ["Invalid login credentials. Please try again."]
        end
      end
    end
  end

  describe "DELETE /api/v1/auth/sign_out" do
    subject { delete(destroy_api_v1_user_session_path, headers: headers) }

    let(:headers) { user.create_new_auth_token }
    let(:user) { create(:user) }
    let(:res) { JSON.parse(response.body) }

    context "正常な値を送信した場合" do
      it "レスポンスが正常" do
        subject
        expect(response).to have_http_status :ok
      end

      it "tokenを削除しログアウトできる" do
        subject
        expect(user.reload.tokens).to be_blank
      end
    end

    context "誤った情報を送信した時" do
      let(:user) { create(:user) }
      let(:headers) do
        {
          "access-token" => "",
          "token-type" => "",
          "client" => "",
          "expiry" => "",
          "uid" => "",
        }
      end
      it "ログインに失敗する" do
        subject
        res = JSON.parse(response.body)
        expect(res["success"]).to eq false
      end
    end
  end
end
