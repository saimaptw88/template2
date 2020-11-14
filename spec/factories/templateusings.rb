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
FactoryBot.define do
  factory :templateusing do
    title { Faker::Internet.domain_word }
    body { Faker::Commerce.department }

    template
  end
end
