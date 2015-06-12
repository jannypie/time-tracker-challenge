TimeTracker.Views.Tasks ||= {}

class TimeTracker.Views.Tasks.TaskView extends Backbone.View
  template: JST["backbone/templates/tasks/task"]

  events:
    "click .destroy" : "destroy"

  attributes: ->
    class: 'entry'

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
