class AddLvtypeIdToLvlist < ActiveRecord::Migration
  def change
    add_column :lvlists, :lvtype_id, :integer
    add_column :lvlists, :type, :string
  end
end
