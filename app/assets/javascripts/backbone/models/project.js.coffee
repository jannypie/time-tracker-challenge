class TimeTracker.Models.Project extends Backbone.Model
  paramRoot: 'project'

  defaults:
    company_id: null
    name: null

class TimeTracker.Collections.ProjectsCollection extends Backbone.Collection
  initialize: (models, options) ->
    @id = options.id

  model: TimeTracker.Models.Project

  url: ->
    '/companies/' + @id + '/projects'

  parse: (response) ->
    response.projects