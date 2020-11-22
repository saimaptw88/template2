class Api::V1::Draft::TemusingController < Api::V1::BaseApplicationController
  # draft一覧
  def show
    template = current_api_v1_user.templates.find(params[:id])
    temusing = template.temusings.all.order(updated_at: :desc).draft
    render json: temusing, each_serializer: Api::V1::TemusingSerializer
  end
end
