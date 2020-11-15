class Api::V1::TemplateusingController < Api::V1::BaseApplicationController
  before_action :set_templateusing, only: [:show, :update, :destroy]

  # テンプレートを活用したテキスト一覧表示( 送信ずみ、下書き )セリアライザー活用
  def index
    templateusings = current_api_v1_user.templateusings.all
    render json: templateusings, each_serializer: Api::V1::TemplateusingSerializer
  end

  # テンプレートを活用したテキスト内容を確認
  def show
    render json: @templateusing, serializer: Api::V1::TemplateusingSerializer
  end

  # テンプレートを活用した新規テキスト作成
  # templateのデータをtemplateusingとして読み込む
  # templateusingとして保存
  def recreate
    #   # binding.pry
    #   tem = current_api_v1_user.templates.find(params[:id])
    #   tem.update!(templateusing_params)
    #   binding.pry
    #   tem.save!
    #   render json: tem
  end

  # テンプレートを活用したテキストを編集
  def update
    @templateusing.update!(templateusing_params)
    render json: @templateusing
  end

  # テンプレートを活用したテキストを削除
  def destroy
    @templateusing.destroy!
  end

  private

    def templateusing_params
      params.require(:templateusing).permit(:title, :body)
    end

    def set_templateusing
      @templateusing = Templateusing.find(params[:id])
    end
end
