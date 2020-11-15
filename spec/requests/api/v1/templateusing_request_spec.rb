require "rails_helper"

RSpec.describe "Api::V1::Templateusings", type: :request do
  # index
  describe "GET  /api/v1/templateusing" do
    subject { get(api_v1_templateusing_index_path, headers: headers) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
      @templateusing = create(:templateusing, user_id: @user.id, template_id: @template.id)
      create_list(:templateusing, 3)
      create_list(:templateusing, 3, user_id: @user.id, template_id: @template.id)

      @array = []
      @tem = Templateusing.all
      @tem.each do |j|
        if j[:user_id] == @user.id
          @array.push(j[:user_id])
        end
      end
    end

    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    it "正常なレスポンスを得る" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "ユーザーに紐づく全てのtemplateusingが返ってくる" do
      subject
      expect(res.map {|i| i["user"]["id"] }).to eq @array
    end
  end

  # show
  describe "GET /api/v1/templateusing/:id" do
    subject { get(api_v1_templateusing_path(templateusing_id), headers: headers) }

    let(:templateusing_id) { @templateusing.id }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
      @templateusing = create(:templateusing, user_id: @user.id, template_id: @template.id)
    end

    context "正常な値を送信" do
      it "正常なレスポンスを得る" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "要求したidのtemplateusingを得る" do
        subject
        expect(res["id"]).to eq templateusing_id
      end

      it "テンプレートに紐づいたtemplateusingを得る" do
        subject
        expect(res["template"]["id"]).to eq @template.id
      end

      it "userに紐付いたtemplateusingを返す" do
        subject
        expect(res["user"]["id"]).to eq @user.id
      end
    end
  end

  # ########################## pass ###############################################
  # recreate
  # describe "POST /api/v1/templateusing/:id/recreate" do
  #   subject { post(recreate_api_v1_templateusing_path(template_id), params: params, headers: headers) }

  #   let(:headers) { @user.create_new_auth_token }
  #   let(:params) { { templateusing: attributes_for(:templateusing) } }
  #   let(:template_id) { @template.id }

  #   before do
  #     @user = create(:user)
  #     @template = create(:template, user_id: @user.id)
  #   end

  #   context "正常な値を送信した場合" do
  #     it "レスポンスが正常" do
  #       #   subject
  #       #   expect(response).to have_http_status(:ok)
  #     end

  #     it "読み込んだtemplateがtemplateusingに保存される" do
  #     end

  #     it "送信された値がタイトルに追記される" do
  #     end

  #     it "送信された値がボディーとして追記される" do
  #     end
  #   end

  #   context "正常でない値を送信した場合" do
  #     it "エラーする" do
  #     end
  #   end
  # end
  #######################################################################################

  # update
  describe "PUT /api/v1/templateusing/:id" do
    subject { put(api_v1_templateusing_path(templateusing_id), params: params, headers: headers) }

    let(:templateusing_id) { @templateusing.id }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      @templateusing = create(:templateusing, user_id: @user.id)
    end

    context "正常な値を送信した場合" do
      let(:params) { { templateusing: attributes_for(:templateusing) } }

      it "レスポンスが正常" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "タイトルが更新されている" do
        subject
        expect(res["title"]).to eq params[:templateusing][:title]
      end

      it "ボディーが更新されている" do
        subject
        expect(res["body"]).to eq params[:templateusing][:body]
      end

      it "変更を許可していない値は更新されない" do
        subject
        expect(res["id"]).to eq @templateusing.id
      end

      it "認証されたユーザーのtemplateusingである" do
        subject
        expect(res["user"]["id"]).to eq @user.id
      end
    end

    context "送信された値のみ更新" do
      let(:params) { { templateusing: { body: Faker::Commerce.department } } }

      it "タイトルは更新されない" do
        subject
        expect(res["title"]).to eq @templateusing.title
      end

      it "ボディーは更新される" do
        subject
        expect(res["body"]).to eq params[:templateusing][:body]
      end
    end
  end

  # destroy
  describe "DELETE /api/v1/templateusing/:id" do
    subject { delete(api_v1_templateusing_path(templateusing_id), headers: headers) }

    let(:templateusing_id) { @templateusing.id }
    let(:headers) { @user.create_new_auth_token }

    before do
      @user = create(:user)
      @templateusing = create(:templateusing)
    end

    it "対象が削除される" do
      expect { subject }.to change { Templateusing.count }.by(-1)
    end
  end
end
