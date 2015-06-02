json.array!(@workrests) do |workrest|
  json.extract! workrest, :id
  json.url workrest_url(workrest, format: :json)
end
