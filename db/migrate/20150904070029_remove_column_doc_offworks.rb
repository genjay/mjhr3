class RemoveColumnDocOffworks < ActiveRecord::Migration
  def change
  	remove_column :doc_offworks, :mins_offduty, :integer
  end
end
