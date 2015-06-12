class TimeTracker.Models.User extends Backbone.Model
  paramRoot: 'user'

  defaults:
    email: null
    password: null

class TimeTracker.Collections.UsersCollection extends Backbone.Collection
  model: TimeTracker.Models.User
  url: '/users'
