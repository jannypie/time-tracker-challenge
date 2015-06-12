TimeTracker.Views.TimeEntries ||= {}

class TimeTracker.Views.TimeEntries.ShowView extends Backbone.View
  template: JST["backbone/templates/time_entries/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
