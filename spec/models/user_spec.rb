# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  allow_password_change  :boolean          default(FALSE)
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  name                   :string
#  provider               :string           default("email"), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  tokens                 :json
#  uid                    :string           default(""), not null
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_name                  (name) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  context "正常な値が送信された場合" do
    let(:user) { create(:user) }

    it "ユーザーが作成される" do
      expect(user).to be_valid
    end
  end

  context "正常でない値が送信された場合" do
    before { @user = create(:user) }

    context "nameが入力されていない場合" do
      let(:user) { build(:user, name: nil) }

      it "ユーザー作成に失敗する" do
        expect(user).to be_invalid
      end
    end

    context "emailが入力されていない場合" do
      let(:user) { build(:user, email: nil) }

      it "ユーザー作成に失敗する" do
        expect(user).to be_invalid
      end
    end

    context "passwordが入力されていない場合" do
      let(:user) { build(:user, password: nil) }

      it "ユーザー作成に失敗する" do
        expect(user).to be_invalid
      end
    end

    context "nameがすでに存在する場合" do
      let(:user) { build(:user, name: @user.name) }

      it "ユーザー作成に失敗する" do
        expect(user).to be_invalid
      end
    end

    context "emailがすでに存在する場合" do
      let(:user) { build(:user, email: @user.email) }

      it "ユーザー作成に失敗する" do
        expect(user).to be_invalid
      end
    end
  end
end
