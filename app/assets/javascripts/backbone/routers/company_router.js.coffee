class TimeTracker.Routers.CompaniesRouter extends Backbone.Router
  initialize: (options) ->
    @companies = new TimeTracker.Collections.CompaniesCollection()
    @companies.reset options.companies

  routes:
    "new"      : "newCompany"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newCompany: ->
    @view = new TimeTracker.Views.Companies.NewView(collection: @companies)
    $("#companies").html(@view.render().el)

  index: ->
    @view = new TimeTracker.Views.Companies.IndexView(collection: @companies)
    $("#companies").html(@view.render().el)

  show: (id) ->
    company = @companies.get(id)

    @view = new TimeTracker.Views.Companies.ShowView(model: company)
    $("#companies").html(@view.render().el)

  edit: (id) ->
    company = @companies.get(id)

    @view = new TimeTracker.Views.Companies.EditView(model: company)
    $("#companies").html(@view.render().el)
