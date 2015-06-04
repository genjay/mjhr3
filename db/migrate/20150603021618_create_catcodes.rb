class CreateCatcodes < ActiveRecord::Migration
  def change
    create_table :catcodes do |t|
      t.string :m_name
      t.string :col_name
      t.string :uid
      t.string :name
      t.boolean :is_stoped
      t.integer :ou_id
      t.text :memo

      t.timestamps null: false
    end
  end
end
