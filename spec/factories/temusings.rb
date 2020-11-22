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
FactoryBot.define do
  factory :temusing do
    title { Faker::Internet.domain_word }
    body { Faker::Commerce.department }

    st = ["draft", "sent"]
    status { st.sample }

    template
  end
end
