json.array!(@offtypes) do |offtype|
  json.extract! offtype, :id, :uid, :name, :mins_of_minimum, :mins_per_unit, :deduct_percent, :include_holiday, :can_duplicate, :is_quota_ctrl, :is_stoped, :memo, :ou_id
  json.url offtype_url(offtype, format: :json)
end
