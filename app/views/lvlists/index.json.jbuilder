json.array!(@lvlists) do |lvlist|
  json.extract! lvlist, :id, :uid, :amt, :ou_id
  json.url lvlist_url(lvlist, format: :json)
end
