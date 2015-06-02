json.array!(@ous) do |ou|
  json.extract! ou, :id, :uid, :name, :overwork_hours_for_freetax, :days_per_month, :hours_per_day, :LP_rate, :welfare_rate, :memo
  json.url ou_url(ou, format: :json)
end
