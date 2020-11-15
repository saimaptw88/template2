class AddTemplateIdToTemplateusings < ActiveRecord::Migration[6.0]
  def change
    add_reference :templateusings, :template, null: false, default: 1, 　foreign_key: true, index: true
  end
end
