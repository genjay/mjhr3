json.array!(@pay_types) do |pay_type|
  json.extract! pay_type, :id, :uid, :name, :cycle_unit, :rule_for_break, :is_stoped, :ou_it, :memo
  json.url pay_type_url(pay_type, format: :json)
end
