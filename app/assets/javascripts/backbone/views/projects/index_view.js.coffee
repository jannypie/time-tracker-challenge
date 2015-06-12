TimeTracker.Views.Projects ||= {}

class TimeTracker.Views.Projects.IndexView extends Backbone.View
  template: JST["backbone/templates/projects/index"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (project) =>
    view = new TimeTracker.Views.Projects.TimeEntryView({model : project})
    @$('#entries').append(view.render().el)

  render: =>
    @$el.html(@template(projects: @collection.toJSON() ))
    @addAll()

    return this
