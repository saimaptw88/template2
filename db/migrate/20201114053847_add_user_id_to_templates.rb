class AddUserIdToTemplates < ActiveRecord::Migration[6.0]
  def change
    add_reference :templates, :user, null: false, default: 1, 　foreign_key: true
  end
end
