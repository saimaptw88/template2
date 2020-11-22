class Api::V1::TemusingController < ApplicationController
  def update
    # DBに保存した場合、他のテーブルに保存できるか確認
    # binding.pry
    template = Template.find(params[:id])
    temusing = template.temusings.create!(temusing_params)
    render json: temusing
  end

  private

    def temusing_params
      params.require(:temusing).permit(:title, :body, :status)
    end
end
