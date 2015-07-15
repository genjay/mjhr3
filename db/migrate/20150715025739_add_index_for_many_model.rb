class AddIndexForManyModel < ActiveRecord::Migration
  def change
  	add_index :catcodes, [:ou_id, :uid], unique: true
  	add_index :departments, [:ou_id, :uid], unique: true
  	add_index :employees, [:ou_id, :uid], unique: true
  	add_index :insurance_settings, [:ou_id, :uid], unique: true
  	add_index :lvlists, [:ou_id, :uid], unique: true
  	add_index :offtypes, [:ou_id, :uid], unique: true
  	add_index :overtypes, [:ou_id, :uid], unique: true
  	add_index :pay_types, [:ou_id, :uid], unique: true
  	add_index :subsidies, [:ou_id, :uid], unique: true
  	add_index :worktypes, [:ou_id, :uid], unique: true 
  end
end
