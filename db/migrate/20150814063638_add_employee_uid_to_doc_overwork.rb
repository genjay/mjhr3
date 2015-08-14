class AddEmployeeUidToDocOverwork < ActiveRecord::Migration
  def change
    add_column :doc_overworks, :employee_uid, :string
  end
end
