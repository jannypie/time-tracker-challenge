TimeTracker.Views.TimeEntries ||= {}

class TimeTracker.Views.TimeEntries.EditView extends Backbone.View
  template: JST["backbone/templates/time_entries/edit"]

  events:
    "submit #edit-time_entry": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (time_entry) =>
        @model = time_entry
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
