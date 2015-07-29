class ChangeCardtimes < ActiveRecord::Migration
  def change
  	add_column :cardtimes, :ou_id, :integer 
  	add_column :cardtimes, :cardno, :string
  	add_column :cardtimes, :dtime, :datetime

  	add_index(:cardtimes, [:ou_id, :dtime])
  end
end
