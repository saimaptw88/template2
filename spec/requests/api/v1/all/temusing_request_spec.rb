require "rails_helper"

RSpec.describe "Api::V1::All::Temusings", type: :request do
  describe "GET /api/v1/all/temusing/:id" do
    subject { get(api_v1_all_temusing_path(temusing_id), headers: headers) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
      @temusing = create(:temusing, template_id: @template.id)
    end

    let(:temusing_id) { @temusing.id }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    it "レスポンスが正常" do
      subject
      expect(response).to have_http_status :ok
    end

    it "ログインしたuser_idに紐づくtemusingである" do
      subject
      expect(Template.find(res["template_id"])["user_id"]).to eq @user.id
    end
  end

  describe " PATCH  /api/v1/all/temusing/:id" do
    subject { patch(api_v1_all_temusing_path(temusing_id), params: params, headers: headers) }

    let(:temusing_id) { @temusing.id }
    let(:params) { { temusing: attributes_for(:temusing) } }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
      @temusing = create(:temusing, template_id: @template.id)
    end

    context "正常な値を送信した場合" do
      it "レスポンスが正常" do
        subject
        expect(response).to have_http_status :ok
      end

      it "titleが更新される" do
        subject
        expect(res["title"]).to eq params[:temusing][:title]
      end

      it "bodyが更新される" do
        subject
        expect(res["body"]).to eq params[:temusing][:body]
      end

      it "statusが更新される" do
        subject
        expect(res["status"]).to eq params[:temusing][:status]
      end
    end
  end

  describe "DELETE /api/v1/all/temusing/:id" do
    subject { delete(api_v1_all_temusing_path(temusing_id), headers: headers) }

    let(:temusing_id) { @temusing.id }
    let(:headers) { @user.create_new_auth_token }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
      @temusing = create(:temusing, template_id: @template.id)
    end

    it "temusingが削除される" do
      expect { subject }.to change { Temusing.count }.by(-1)
    end
  end
end
