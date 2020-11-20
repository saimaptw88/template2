class Api::V1::TemusingController < ApplicationController
  def update
    # # テスト実装済み
    # template = current_api_v1_user.templates.find(params[:id])
    # template.update!(template_params)
    # render json: template

    # DBに保存した場合、他のテーブルに保存できるか確認
    template = Template.find(params[:id])
    temusing = template.temusings.create!(temusing_params)
    render json: temusing
  end

  private

    def temusing_params
      params.require(:temusing).permit(:title, :body)
    end
end
