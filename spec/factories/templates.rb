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
FactoryBot.define do
  factory :template do
    title { Faker::Internet.domain_word }
    body { Faker::Commerce.department }

    user
  end
end
