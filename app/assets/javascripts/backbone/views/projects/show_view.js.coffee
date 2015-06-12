TimeTracker.Views.Projects ||= {}

class TimeTracker.Views.Projects.ShowView extends Backbone.View
  template: JST["backbone/templates/projects/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
