class CreateTemusings < ActiveRecord::Migration[6.0]
  def change
    create_table :temusings do |t|
      t.string :title
      t.string :body

      t.timestamps
    end

    add_index :temusings, :title, unique: true
  end
end
