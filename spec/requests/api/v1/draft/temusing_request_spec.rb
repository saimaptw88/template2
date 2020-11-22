require "rails_helper"

RSpec.describe "Api::V1::Draft::Temusings", type: :request do
  describe "GET    /api/v1/draft/temusing/:id" do
    subject { get(api_v1_draft_temusing_path(template_id), headers: headers) }

    let(:template_id) { @template.id }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
      @temusing = create(:temusing, template_id: @template.id, status: :sent)
      @temusing1 = create(:temusing, template_id: @template.id, status: :draft)
      @temusing2 = create(:temusing, template_id: @template.id, status: :draft, updated_at: 1.days.ago)
      @temusing3 = create(:temusing, template_id: @template.id, status: :draft, updated_at: 2.days.ago)

      @array = []
      3.times { @array.push("draft") }

      @array2 = []
      3.times { @array2.push(@template.id) }
    end

    it "正常なレスポンス" do
      subject
      expect(response).to have_http_status :ok
    end

    it "draftの記事のみ取得" do
      subject
      expect(res.map {|i| i["status"] }).to eq @array
    end

    it "template_idに紐づいたtemusingである" do
      subject
      expect(res.map {|i| i["template"]["id"] }).to eq @array2
    end

    it "temusingがupdated_atについて降順である" do
      subject
      expect(res.map {|i| i["id"] }).to eq [@temusing1.id, @temusing2.id, @temusing3.id]
    end
  end
end
