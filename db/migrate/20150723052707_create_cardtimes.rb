class CreateCardtimes < ActiveRecord::Migration
  def change
    create_table :cardtimes do |t|
      t.text :up_data

      t.timestamps null: false
    end
  end
end
