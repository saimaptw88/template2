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
FactoryBot.define do
  factory :templateusing do
    title { "MyString" }
    body { "MyText" }

    template
  end
end
