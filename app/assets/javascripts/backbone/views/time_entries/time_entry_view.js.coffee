TimeTracker.Views.TimeEntries ||= {}

class TimeTracker.Views.TimeEntries.TimeEntryView extends Backbone.View
  template: JST["backbone/templates/time_entries/timeentry"]

  initialize: () ->
    @getProjectDetail(@model.attributes.project_id)
    @getTaskDetail(@model.attributes.task_id)
    @getCompanyDetail(@model.attributes.company_id)

  events:
    "click .destroy" : "destroy"

  attributes: ->
    class: 'time-entry card'

  destroy: () ->
    @model.destroy()
    this.remove()
    return false

  getProjectDetail: (id) ->
    for project in TimeTracker.Projects
      if project.id == id
        @model.attributes.project_name = project.attributes.name
        @model.attributes.company_id = project.attributes.company_id

  getTaskDetail: (id) ->
    for task in TimeTracker.Tasks
      if task.id == id
        @model.attributes.task_name = task.attributes.name

  getCompanyDetail: (id) ->
    for company in TimeTracker.Companies
      if company.id == id
        @model.attributes.company_name = company.attributes.name

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
