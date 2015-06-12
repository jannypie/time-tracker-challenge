json.time_entry do
  json.partial! 'time_entries/time_entry', time_entry: @time_entry
end
