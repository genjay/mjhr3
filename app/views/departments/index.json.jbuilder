json.array!(@departments) do |department|
  json.extract! department, :id, :uid, :name, :worktype_id, :upper_id, :is_stoped, :memo, :ou_id
  json.url department_url(department, format: :json)
end
