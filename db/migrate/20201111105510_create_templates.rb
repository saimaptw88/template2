class CreateTemplates < ActiveRecord::Migration[6.0]
  def change
    create_table :templates do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
