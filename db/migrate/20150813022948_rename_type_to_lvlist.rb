class RenameTypeToLvlist < ActiveRecord::Migration
  def change
    rename_column :lvlists, :type, :lvtype_uid
  end
end