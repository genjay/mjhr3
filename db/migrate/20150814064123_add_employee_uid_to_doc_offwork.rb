class AddEmployeeUidToDocOffwork < ActiveRecord::Migration
  def change
    add_column :doc_offworks, :employee_uid, :string
  end
end
