class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :uid
      t.string :name
      t.integer :department_id
      t.string :id_number
      t.date :arrive_date
      t.date :levae_date
      t.date :birthday
      t.string :sex
      t.string :marriage
      t.string :education
      t.string :school
      t.string :tel1
      t.string :tel2
      t.string :address1
      t.string :address2
      t.string :email
      t.string :cardno_of_duty
      t.integer :ou_id
      t.text :memo

      t.timestamps null: false
    end
  end
end
