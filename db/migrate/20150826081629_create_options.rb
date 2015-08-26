class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :model_title
      t.string :column_title
      t.string :key
      t.string :value
      t.string :status_rule
      t.text :memo

      t.timestamps null: true
    end
  end
end
