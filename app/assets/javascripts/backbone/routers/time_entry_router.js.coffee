class TimeTracker.Routers.TimeEntriesRouter extends Backbone.Router
  initialize: (options) ->
    @time_entries = new TimeTracker.Collections.TimeEntriesCollection()
    @time_entries.reset options.time_entries

  routes:
    "new"      : "newTimeEntry"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newTimeEntry: ->
    @view = new TimeTracker.Views.TimeEntries.NewView(collection: @time_entries)
    $("#time-entry_new").html(@view.render().el)

  index: ->
    @view = new TimeTracker.Views.TimeEntries.IndexView(collection: @time_entries)
    $("#timetracker").html(@view.render().el)

  show: (id) ->
    time_entry = @time_entries.get(id)

    @view = new TimeTracker.Views.TimeEntries.ShowView(model: time_entry)
    $("#timetracker").html(@view.render().el)

  edit: (id) ->
    time_entry = @time_entries.get(id)

    @view = new TimeTracker.Views.TimeEntries.EditView(model: time_entry)
    $("#timetracker").html(@view.render().el)
