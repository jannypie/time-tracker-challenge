class TimeTracker.Routers.ProjectsRouter extends Backbone.Router
  initialize: (options) ->
    @projects = new TimeTracker.Collections.ProjectsCollection()
    @projects.reset options.projects

  routes:
    "new"      : "newProject"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newProject: ->
    @view = new TimeTracker.Views.Projects.NewView(collection: @projects)
    $("#projects").html(@view.render().el)

  index: ->
    @view = new TimeTracker.Views.Projects.IndexView(collection: @projects)
    $("#projects").html(@view.render().el)

  show: (id) ->
    project = @projects.get(id)

    @view = new TimeTracker.Views.Projects.ShowView(model: project)
    $("#projects").html(@view.render().el)

  edit: (id) ->
    project = @projects.get(id)

    @view = new TimeTracker.Views.Projects.EditView(model: project)
    $("#projects").html(@view.render().el)
