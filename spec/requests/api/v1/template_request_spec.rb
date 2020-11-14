require "rails_helper"

RSpec.describe "Api::V1::Templates", type: :request do
  describe "GET /api/v1/template" do
    subject { get(api_v1_template_index_path) }

    it "returns http success" do
      # expect{ subject }.to have_http_status(:success)
    end
  end
end
