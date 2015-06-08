class CreatePayTypes < ActiveRecord::Migration
  def change
    create_table :pay_types do |t|
      t.string :uid
      t.string :name
      t.string :cycle_unit
      t.string :rule_for_break
      t.boolean :is_stoped
      t.integer :ou_id
      t.text :memo

      t.timestamps null: false
    end
  end
end
