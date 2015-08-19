json.array!(@month_others) do |month_other|
  json.extract! month_other, :id, :ou_id, :employee_id, :yyyymm, :pay_type_id, :amt
  json.url month_other_url(month_other, format: :json)
end
