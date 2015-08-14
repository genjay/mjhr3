class AlterMonthDuties < ActiveRecord::Migration
  def change
    add_column :month_duties, :over_a, :integer, default: 0
    add_column :month_duties, :over_b, :integer, default: 0
    add_column :month_duties, :over_c, :integer, default: 0
    add_column :month_duties, :over_h, :integer, default: 0
  end
end
