class Api::V1::Sent::TemusingController < Api::V1::BaseApplicationController
  def index
    temusings = current_api_v1_user.temusings.all.sent
    render json: temusings
  end
end
