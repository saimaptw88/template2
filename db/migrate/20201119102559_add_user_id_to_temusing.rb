class AddUserIdToTemusing < ActiveRecord::Migration[6.0]
  def change
    add_reference :temusings, :user, null: false, default: 1, 　foreign_key: true, index: true
  end
end
