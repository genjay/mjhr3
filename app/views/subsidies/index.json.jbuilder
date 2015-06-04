json.array!(@subsidies) do |subsidy|
  json.extract! subsidy, :id, :uid, :name, :rate, :memo, :is_stoped, :ou_id
  json.url subsidy_url(subsidy, format: :json)
end
