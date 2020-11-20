require "rails_helper"

RSpec.describe "Api::V1::Temusings", type: :request do
  describe "PATCH /api/v1/temusing/:id " do
    subject { patch(api_v1_temusing_path(template_id), params: params) }

    let(:template_id) { @template.id }
    let(:params) { { temusing: attributes_for(:temusing) } }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
    end

    it "レスポンスが正常" do
      subject
      expect(response).to have_http_status(:success)
    end

    # # 実装済み
    # it "titleが更新される" do
    #   subject
    #   expect(params[:template][:title]).to eq res["title"]
    # end

    # it "bodyが更新される" do
    #   subject
    #   expect(params[:template][:body]).to eq res["body"]
    # end

    # it "テーブルを更新しない" do
    #   subject
    #   expect(@template).to eq Template.find(@template.id)
    # end

    # 別のテーブルに保存できるか
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
  end
end
