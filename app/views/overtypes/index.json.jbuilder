json.array!(@overtypes) do |overtype|
  json.extract! overtype, :id, :uid, :name, :mins_of_A, :mins_of_B, :rate_of_A, :amt_of_A, :rate_of_B, :amt_of_B, :rate_of_C, :amt_of_C, :rate_of_H, :amt_of_H, :mins_per_unit, :valid_unit, :is_stoped, :pay_type, :memo, :ou_id
  json.url overtype_url(overtype, format: :json)
end
