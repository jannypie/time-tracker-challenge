json.time_entries do
  json.array! @time_entries, partial: 'time_entries/time_entry', as: :time_entry
end
