require "rails_helper"

RSpec.describe "Api::V1::Temusings", type: :request do
  describe "PATCH /api/v1/temusing/:id " do
    subject { patch(api_v1_temusing_path(template_id), params: params, headers: headers) }

    let(:template_id) { @template.id }
    let(:params) { { template: attributes_for(:template) } }
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

    it "titleが更新される" do
      subject
      expect(params[:template][:title]).to eq res["title"]
    end

    it "bodyが更新される" do
      subject
      expect(params[:template][:body]).to eq res["body"]
    end

    it "テーブルを更新しない" do
      subject
      expect(@template).to eq Template.find(@template.id)
    end
  end
end
