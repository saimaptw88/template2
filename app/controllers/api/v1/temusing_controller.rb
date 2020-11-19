class Api::V1::TemusingController < ApplicationController
  def update
    template = current_api_v1_user.templates.find(params[:id])
    template.update!(template_params)
    render json: template
    # DBに変更を保存されていないか確認
    # DBに保存した場合、他のテーブルに保存できるか確認
  end

  private

    def template_params
      params.require(:template).permit(:title, :body)
    end
end
