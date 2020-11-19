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
FactoryBot.define do
  factory :temusing do
    title { Faker::Internet.domain_word }
    body { Faker::Commerce.department }

    user
    template
  end
end
