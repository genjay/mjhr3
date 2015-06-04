json.array!(@insurance_settings) do |insurance_setting|
  json.extract! insurance_setting, :id, :uid, :name, :is_stoped, :memo, :ou_id, :a_rate, :a_employee, :a_compayny, :b_rate, :b_employee, :b_compayny, :c_rate, :c_employee, :c_compayny, :d_rate, :d_employee, :d_compayny, :e_rate, :e_employee, :e_compayny
  json.url insurance_setting_url(insurance_setting, format: :json)
end
