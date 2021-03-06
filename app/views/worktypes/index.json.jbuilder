json.array!(@worktypes) do |worktype|
  json.extract! worktype, :id, :uid, :name, :on_duty_at, :off_duty_at, :buffer_before_duty, :buffer_after_duty, :minimum_before_overwork, :minimum_after_overwork, :minimum_holiday_overwork, :range_on, :range_off, :is_stoped, :mins_of_duty, :memo, :ou_id
  json.url worktype_url(worktype, format: :json)
end
