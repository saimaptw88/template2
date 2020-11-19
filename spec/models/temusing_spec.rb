# == Schema Information
#
# Table name: temusings
#
#  id          :bigint           not null, primary key
#  body        :string
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  template_id :bigint           default(1), not null
#  user_id     :bigint           default(1), not null
#
# Indexes
#
#  index_temusings_on_template_id  (template_id)
#  index_temusings_on_title        (title) UNIQUE
#  index_temusings_on_user_id      (user_id)
#
require "rails_helper"

RSpec.describe Temusing, type: :model do
  context "正常な値が送信された場合" do
    let(:temusing) { build(:temusing) }

    it "テーブルに保存されない" do
      expect { temusing }.to change { Temusing.count }.by(0)
    end
  end
end
