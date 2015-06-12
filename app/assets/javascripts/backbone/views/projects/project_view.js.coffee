TimeTracker.Views.Projects ||= {}

class TimeTracker.Views.Projects.ProjectView extends Backbone.View
  template: JST["backbone/templates/projects/timeentry"]

  events:
    "click .destroy" : "destroy"

  attributes: ->
    class: 'entry'

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  populateProjects: () ->
    console.log "project"

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
