class AddStatusToTemusing < ActiveRecord::Migration[6.0]
  def change
    add_column :temusings, :status, :integer, default: 0
    # add_index :temusings, :status
  end
end
