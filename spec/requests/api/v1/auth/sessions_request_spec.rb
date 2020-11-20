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
end
