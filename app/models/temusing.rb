# == Schema Information
#
# Table name: temusings
#
#  id          :bigint           not null, primary key
#  body        :string
#  status      :integer          default("draft")
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  template_id :bigint           default(1), not null
#
# Indexes
#
#  index_temusings_on_template_id  (template_id)
#  index_temusings_on_title        (title) UNIQUE
#
class Temusing < ApplicationRecord
  belongs_to :template

  enum status: {
    draft: 0,
    sent: 1,
  }

  validates :status, presence: true
end
