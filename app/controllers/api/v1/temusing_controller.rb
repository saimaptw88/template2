class Api::V1::TemusingController < Api::V1::BaseApplicationController
  def update
    # DBに保存した場合、他のテーブルに保存できるか確認
    # binding.pry
    template = current_api_v1_user.templates.find(params[:id])
    temusing = template.temusings.new(temusing_params)
    temusing.user = current_api_v1_user
    temusing.save!
    render json: temusing
  end

  private

    def temusing_params
      params.require(:temusing).permit(:title, :body, :status)
    end
end
