# == Schema Information
#
# Table name: templateusings
#
#  id          :bigint           not null, primary key
#  body        :text
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  template_id :bigint           default(1), not null
#
# Indexes
#
#  index_templateusings_on_template_id  (template_id)
#
# Foreign Keys
#
#  fk_rails_...  (template_id => templates.id)
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
