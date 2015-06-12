#= require_self
#= require_tree ./templates
#= require_tree ./models
#= require_tree ./views
#= require_tree ./routers

window.TimeTracker =
  Models: {}
  Collections: {}
  Routers: {}
  Views: {}

$ ->
  TimeTracker.Projects = []
  TimeTracker.Tasks = []

  company_collection = new TimeTracker.Collections.CompaniesCollection();
  company_collection.fetch
    success: (company_collection) ->
      TimeTracker.Companies = company_collection.models
      companies = TimeTracker.Companies
      $(companies).each (i,el) ->
        getCompanyProjects(el,el.attributes.id)
        getCompanyTasks(el,el.attributes.id)
      initializeApp()

  getCompanyProjects = (company,company_id) ->
    project_collection = new TimeTracker.Collections.ProjectsCollection([], {id: company_id});
    project_collection.fetch
      success: (project_collection) ->
        company.Projects = project_collection.toJSON()
        $(project_collection.models).each (i,el) ->
          TimeTracker.Projects.push el

  getCompanyTasks = (company,company_id) ->
    task_collection = new TimeTracker.Collections.TasksCollection([], {id: company_id});
    task_collection.fetch
      success: (task_collection) ->
        company.Tasks = task_collection.toJSON()
        $(task_collection.models).each (i,el) ->
          TimeTracker.Tasks.push el

  initializeApp = () ->
    collection = new TimeTracker.Collections.TimeEntriesCollection();
    collection.fetch
      success: (collection) ->
        new TimeTracker.Routers.TimeEntriesRouter({time_entries: collection.toJSON()});
        Backbone.history.start();
        TimeTracker.Entries = collection
