class TimeTracker.Routers.UsersRouter extends Backbone.Router
  initialize: (options) ->
    @users = new Timetracker.Collections.UsersCollection()
    @users.reset options.users

  routes:
    "new"      : "newUser"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newUser: ->
    @view = new Timetracker.Views.Users.NewView(collection: @users)
    $("#users").html(@view.render().el)

  index: ->
    @view = new Timetracker.Views.Users.IndexView(collection: @users)
    $("#users").html(@view.render().el)

  show: (id) ->
    user = @users.get(id)

    @view = new Timetracker.Views.Users.ShowView(model: user)
    $("#users").html(@view.render().el)

  edit: (id) ->
    user = @users.get(id)

    @view = new Timetracker.Views.Users.EditView(model: user)
    $("#users").html(@view.render().el)
