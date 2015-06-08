json.array!(@employees) do |employee|
  json.extract! employee, :id, :uid, :name, :department_id, :id_number, :arrive_date, :levae_date, :birthday, :sex, :marriage, :education, :school, :tel1, :tel2, :address1, :address2, :email, :cardno_of_duty
  json.url employee_url(employee, format: :json)
end
