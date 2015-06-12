class TimeTracker.Models.TimeEntry extends Backbone.Model
  paramRoot: 'time_entry'
  # parse: (response) ->
  #   response.time_entry


class TimeTracker.Collections.TimeEntriesCollection extends Backbone.Collection
  model: TimeTracker.Models.TimeEntry
  url: '/time_entries'
  parse: (response) ->
    response.time_entries
