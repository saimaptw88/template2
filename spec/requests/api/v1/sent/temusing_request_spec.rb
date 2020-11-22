require "rails_helper"

RSpec.describe "Api::V1::Sent::Temusings", type: :request do
  describe "GET    /api/v1/sent/temusing" do
    subject { get(api_v1_sent_temusing_index_path, headers: headers) }

    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
      create_list(:temusing, 3, template_id: @template.id, user_id: @user.id, status: :sent)
    end

    it "レスポンスが正常" do
      subject
      expect(response).to have_http_status :ok
    end

    it "ユーザーに紐づくtemusingを取得" do
      subject
      expect(res.map {|i| i["user_id"] }).to eq [@user.id, @user.id, @user.id]
    end

    it "templateに紐づくtemusingを取得" do
      subject
      expect(res.map {|i| i["template_id"] }).to eq [@template.id, @template.id, @template.id]
    end

    it "sentのtemusingを取得" do
      subject
      expect(res.map {|i| i["status"] }).to eq ["sent", "sent", "sent"]
    end
  end
end
