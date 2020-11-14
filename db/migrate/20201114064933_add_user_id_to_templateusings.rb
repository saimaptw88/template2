class AddUserIdToTemplateusings < ActiveRecord::Migration[6.0]
  def change
    add_reference :templateusings, :template, null: false, default: 1, foreign_key: true
  end
end
