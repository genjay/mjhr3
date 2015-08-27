class AddColumnOfPaytypes < ActiveRecord::Migration
  def change
  	add_column :month_salaries, :type, :string
  	add_column :pay_types, :overwork_base, :boolean, default: false
  	add_column :pay_types, :offwork_base, :boolean, default: false
  	remove_column :daily_duties, :over_a, :integer
  	remove_column :daily_duties, :over_b, :integer
  	remove_column :daily_duties, :over_c, :integer
  	remove_column :daily_duties, :over_h, :integer

  end
end
