class FixColumnNamePayType < ActiveRecord::Migration
  def change
  	rename_column :pay_types, :ou_it, :ou_id
  end
end
