TimeTracker.Views.Projects ||= {}

class TimeTracker.Views.Projects.EditView extends Backbone.View
  template: JST["backbone/templates/projects/edit"]

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
