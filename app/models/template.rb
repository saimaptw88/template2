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
class Template < ApplicationRecord
  belongs_to :user
  has_many :temusings, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end
