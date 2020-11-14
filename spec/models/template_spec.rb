# == Schema Information
#
# Table name: templates
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           default(1), not null
#
# Indexes
#
#  index_templates_on_title    (title) UNIQUE
#  index_templates_on_user_id  (user_id)
#
require "rails_helper"

RSpec.describe Template, type: :model do
  context "titleが入力され、一意の場合" do
    it "作成される" do
      template = create(:template)
      expect(template).to be_valid
    end
  end

  context "titleが入力されていない" do
    let(:template) { build(:template, title: nil) }

    it "エラーする" do
      expect(template).to be_invalid
    end
  end

  context "titleが一意出ない場合" do
    before { @temp = create(:template) }

    let(:template) { build(:template, title: @temp.title) }

    it "エラーする" do
      expect(template).to be_invalid
    end
  end

  context "紐づくuserが存在しない場合" do
    let(:template) { build(:template, user: nil) }

    it "エラーする" do
      expect(template).to be_invalid
    end
  end
end
