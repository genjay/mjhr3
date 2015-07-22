class AddOvertypeIdToDocOverworks < ActiveRecord::Migration
  def change
    add_column :doc_overworks, :overtype_id, :integer
  end
end
