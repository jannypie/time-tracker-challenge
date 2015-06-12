class TimeTracker.Models.Company extends Backbone.Model
  paramRoot: 'company'

  defaults:
    name: null

class TimeTracker.Collections.CompaniesCollection extends Backbone.Collection
  model: TimeTracker.Models.Company
  url: '/companies'
  parse: (response) ->
    response.companies