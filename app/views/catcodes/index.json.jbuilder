json.array!(@catcodes) do |catcode|
  json.extract! catcode, :id, :m_name, :col_name, :uid, :name, :is_stoped, :ou_id, :memo
  json.url catcode_url(catcode, format: :json)
end
