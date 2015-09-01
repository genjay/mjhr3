class RemoveColumnOfDocOverworks < ActiveRecord::Migration
  def change
  	remove_column :doc_overworks, :amt_A, :integer, :default => 0
  	remove_column :doc_overworks, :amt_B, :integer, :default => 0
  	remove_column :doc_overworks, :amt_C, :integer, :default => 0
  	remove_column :doc_overworks, :amt_H, :integer, :default => 0

  end
end
