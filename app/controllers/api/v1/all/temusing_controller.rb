class Api::V1::All::TemusingController < Api::V1::BaseApplicationController
  before_action :set_temusing, only: [:show, :update, :destroy]

  def show
    render json: @temusing
  end

  def update
    @temusing.update!(temusing_params)
    render json: @temusing
  end

  def destroy
    @temusing.destroy
  end

  private

    def temusing_params
      params.require(:temusing).permit(:title, :body, :status)
    end

    def set_temusing
      @temusing = Temusing.find(params[:id])
    end
end
