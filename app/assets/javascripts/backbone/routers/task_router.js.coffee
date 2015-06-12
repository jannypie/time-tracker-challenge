class TimeTracker.Routers.TasksRouter extends Backbone.Router
  initialize: (options) ->
    @tasks = new TimeTracker.Collections.TasksCollection()
    @tasks.reset options.tasks

  routes:
    "new"      : "newTask"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newTask: ->
    @view = new TimeTracker.Views.Tasks.NewView(collection: @tasks)
    $("#tasks").html(@view.render().el)

  index: ->
    @view = new TimeTracker.Views.Tasks.IndexView(collection: @tasks)
    $("#tasks").html(@view.render().el)

  show: (id) ->
    task = @tasks.get(id)

    @view = new TimeTracker.Views.Tasks.ShowView(model: task)
    $("#tasks").html(@view.render().el)

  edit: (id) ->
    task = @tasks.get(id)

    @view = new TimeTracker.Views.Tasks.EditView(model: task)
    $("#tasks").html(@view.render().el)
