require "rails_helper"

RSpec.describe "Api::V1::Temusings", type: :request do
  describe "PATCH /api/v1/temusing/:id " do
    subject { patch(api_v1_temusing_path(template_id), params: params, headers: headers) }

    let(:template_id) { @template.id }
    let(:params) { { temusing: attributes_for(:temusing) } }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
    end

    it "レスポンスが正常" do
      subject
      expect(response).to have_http_status(:success)
    end

    it "temusingテーブルに保存する" do
      expect { subject }.to change { Temusing.count }.by(1)
    end

    it "templateのテーブルにはデータが保存されない" do
      expect { subject }.to change { Template.count }.by(0)
    end

    it "titleが更新される" do
      subject
      expect(res["title"]).to eq params[:temusing][:title]
    end

    it "bodyが更新される" do
      subject
      expect(res["body"]).to eq params[:temusing][:body]
    end

    it "statusが入力されている" do
      subject
      expect(res["status"]).to eq params[:temusing][:status]
    end
  end
end
