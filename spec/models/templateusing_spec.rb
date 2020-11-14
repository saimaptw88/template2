# == Schema Information
#
# Table name: templateusings
#
#  id         :bigint           not null, primary key
#  body       :text
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Templateusing, type: :model do
  context "紐づくtemplateが存在する場合" do
    it "作成に成功する" do
    end
  end

  context "紐づくtemplateが存在しない場合" do
    it "エラーする" do
    end
  end
end
