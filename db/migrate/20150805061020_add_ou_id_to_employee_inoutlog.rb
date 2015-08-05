class AddOuIdToEmployeeInoutlog < ActiveRecord::Migration
  def change
    add_column :employee_inoutlogs, :ou_id, :integer
  end
end
