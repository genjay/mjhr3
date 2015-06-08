class CreateSubsidies < ActiveRecord::Migration
  def change
    create_table :subsidies do |t|
      t.string :uid
      t.string :name
      t.decimal :rate, precision: 7, scale: 4
      t.text :memo
      t.boolean :is_stoped
      t.integer :ou_id

      t.timestamps null: false
    end
  end
end
