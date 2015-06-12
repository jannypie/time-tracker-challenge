class TimeTracker.Models.Task extends Backbone.Model
  paramRoot: 'task'

  defaults:
    company_id: null
    name: null

class TimeTracker.Collections.TasksCollection extends Backbone.Collection
  model: TimeTracker.Models.Task
  url: '/tasks'
  initialize: (models, options) ->
    @id = options.id

  model: TimeTracker.Models.Task

  url: ->
    '/companies/' + @id + '/tasks'

  parse: (response) ->
    response.tasks