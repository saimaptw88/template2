class Api::V1::TemplateController < Api::V1::BaseApplicationController
  before_action :set_template, only: [:show, :update, :destroy]

  def index
    templates = current_api_v1_user.templates.all
    render json: templates, each_serialiser: Api::V1::TemplateSerializer
  end

  def create
    template = current_api_v1_user.templates.create!(template_params)
    render json: template
  end

  def show
    render json: @template, serializer: Api::V1::TemplateSerializer
  end

  def update
    @template.update!(template_params)
    render json: @template
  end

  def destroy
    @template.destroy
  end

  private

    def template_params
      params.require(:template).permit(:title, :body)
    end

    def set_template
      @template = current_api_v1_user.templates.find(params[:id])
    end
end
