TimeTracker.Views.TimeEntries ||= {}

class TimeTracker.Views.TimeEntries.IndexView extends Backbone.View
  template: JST["backbone/templates/time_entries/index"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  attributes: ->
    id: 'time-entries'

  addAll: () =>
    @collection.each(@addOne)

  addOne: (time_entry) =>
    view = new TimeTracker.Views.TimeEntries.TimeEntryView({model : time_entry})
    @$('#entries').append(view.render().el)

  render: =>
    $('#timetracker').html(@$el.html(@template(time_entries: @collection.toJSON() )))
    @addAll()

    return this
