json.array!(@annual_leave_lists) do |annual_leave_list|
  json.extract! annual_leave_list, :id, :months_of_job, :days, :memo, :ou_id
  json.url annual_leave_list_url(annual_leave_list, format: :json)
end
