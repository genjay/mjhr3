class AddEmployeeUidToDocForget < ActiveRecord::Migration
  def change
    add_column :doc_forgets, :employee_uid, :string
  end
end
