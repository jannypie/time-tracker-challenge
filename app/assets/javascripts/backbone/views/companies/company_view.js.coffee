TimeTracker.Views.Companies ||= {}

class TimeTracker.Views.Companies.CompanyView extends Backbone.View
  template: JST["backbone/templates/companies/timeentry"]

  events:
    "click .destroy" : "destroy",
    "select #company" : "populateProjects"

  attributes: ->
    class: 'entry'

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  populateProjects: () ->
    console.log "hey"

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
