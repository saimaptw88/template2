require "rails_helper"

RSpec.describe "Api::V1::Templates", type: :request do
  # index
  describe "GET /api/v1/template" do
    subject { get(api_v1_template_index_path, headers: headers) }

    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      create_list(:template, 3)
      3.times { @user.templates.create(title: Faker::Internet.domain_word, body: Faker::Commerce.department) }

      @array = []
      tem = Template.all
      tem.each do |i|
        if i[:user_id] == @user.id
          @array.push(i[:user_id])
        end
      end
    end

    it "レスポンスが正常" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "ユーザーに紐づいたテンプレートが返ってくる" do
      subject
      expect(res.map {|x| x["user"]["id"] }).to eq @array
    end
  end

  # show
  describe "GET /api/v1/template/:id" do
    subject { get(api_v1_template_path(template_id), headers: headers) }

    before {  @user = create(:user) }

    let(:template_id) { @template.id }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    context "ユーザーに紐づいたテンプレートである場合" do
      before do
        @template = @user.templates.create!(title: Faker::Internet.domain_word, body: Faker::Commerce.department)
        create_list(:template, 3)
        create_list(:template, 3, user_id: @user.id)
      end

      it "正常なレスポンスを返す" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "ログインユーザーと同じuser_idのテンプレートを取得" do
        subject
        expect(res["user"]["id"]).to eq @user.id
      end

      it "指定したidのテンプレートを取得" do
        subject
        expect(res["id"]).to eq @template.id
      end
    end

    context "ユーザーに紐づいていないテンプレートの場合" do
      before { @template = create(:template, user_id: user.id) }

      let(:user) { create(:user) }

      it "エラー" do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  # new
  describe "get /api/v1/template/new" do
    subject { get(new_api_v1_template_path, params: params, headers: headers) }

    let(:params) { { template: attributes_for(:template) } }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
    end

    it "レスポンスが正常" do
      subject
      expect(response).to have_http_status(:ok)
    end

    it "要求したtitleが登録される" do
      subject
      expect(res["title"]).to eq params[:template][:title]
    end

    it "要求したbodyが登録される" do
      subject
      expect(res["body"]).to eq params[:template][:body]
    end

    it "作成したインスタンスが保存されない" do
      subject
      expect { subject }.to change { Template.count }.by(0)
    end
  end

  # create
  describe "POST /api/v1/template" do
    subject { post(api_v1_template_index_path, params: params, headers: headers) }

    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    before { @user = create(:user) }

    context "適切なパラメータを送信する" do
      let(:params) { { template: attributes_for(:template) } }

      it "レスポンスが正常" do
        subject
        expect(response).to have_http_status(:ok)
      end

      it "正常にテンプレートが保存される" do
        expect { subject }.to change { Template.count }.by(1)
      end

      it "titleが正常" do
        subject
        expect(res["title"]).to eq params[:template][:title]
      end

      it "bodyが正常" do
        subject
        expect(res["body"]).to eq params[:template][:body]
      end
    end

    context "正常なパラメータを送信しない場合" do
      let(:params) { { template: attributes_for(:template, title: "") } }

      it "エラー" do
        expect { subject }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  # update
  describe "PUTCH, PUT /api/v1/template/:id" do
    subject { put(api_v1_template_path(template_id), params: params, headers: headers) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
    end

    let(:template_id) { @template.id }
    let(:headers) { @user.create_new_auth_token }
    let(:res) { JSON.parse(response.body) }

    context "正常なパラメータを送信した場合" do
      context "title, body共に送信した場合" do
        let(:params) { { template: attributes_for(:template) } }

        it "レスポンスが正常" do
          subject
          expect(response).to have_http_status(:ok)
        end
      end

      context "titleのみ送信した場合" do
        let(:params) { { template: { title: Faker::Internet.domain_word } } }

        it "titleが更新される" do
          subject
          expect(res["title"]).to eq params[:template][:title]
        end

        it "bodyが変更されない" do
          subject
          expect(res["body"]).to eq @template.body
        end
      end

      context "bodyのみ送信した場合" do
        let(:params) { { template: { body: Faker::Commerce.department } } }

        it "titleは更新されない" do
          subject
          expect(res["title"]).to eq @template.title
        end

        it "bodyは更新される" do
          subject
          expect(res["body"]).to eq params[:template][:body]
        end
      end
    end

    context "正常でないパラメータを送信した場合" do
      let(:params) { { template: { id: "123" } } }

      it "title変化なし" do
        subject
        expect(res["title"]).to eq @template.title
      end

      it "body変化なし" do
        subject
        expect(res["body"]).to eq @template.body
      end

      it "id変化なし" do
        subject
        expect(res["id"]).to eq @template.id
      end
    end
  end

  # destroy
  describe "DELETE /api/v1/template/:id" do
    subject { delete(api_v1_template_path(template_id), headers: headers) }

    before do
      @user = create(:user)
      @template = create(:template, user_id: @user.id)
      create_list(:template, 3)
    end

    let(:template_id) { @template.id }
    let(:headers) { @user.create_new_auth_token }

    it "対象が削除される" do
      expect { subject }.to change { Template.count }.by(-1)
    end
  end
end
