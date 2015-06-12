TimeTracker.Views.Tasks ||= {}

class TimeTracker.Views.Tasks.IndexView extends Backbone.View
  template: JST["backbone/templates/tasks/index"]

  initialize: () ->
    @collection.bind('reset', @addAll)

  addAll: () =>
    @collection.each(@addOne)

  addOne: (tasks) =>
    view = new TimeTracker.Views.Tasks.TaskView({model : tasks})
    @$('#entries').append(view.render().el)

  render: =>
    @$el.html(@template(tasks: @collection.toJSON() ))
    @addAll()

    return this
