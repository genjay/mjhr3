class AddColumnToDocOverworks < ActiveRecord::Migration
  def change
  	add_column :doc_overworks, :amt_A, :integer, :default => 0
  	add_column :doc_overworks, :amt_B, :integer, :default => 0
  	add_column :doc_overworks, :amt_C, :integer, :default => 0
  	add_column :doc_overworks, :amt_H, :integer, :default => 0
  end
end
