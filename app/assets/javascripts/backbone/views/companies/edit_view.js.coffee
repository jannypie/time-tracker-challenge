TimeTracker.Views.Companies ||= {}

class TimeTracker.Views.Companies.EditView extends Backbone.View
  template: JST["backbone/templates/companies/edit"]

  events:
    "submit #edit-companies": "update"

  update: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success: (company) =>
        @model = company
        window.location.hash = "/#{@model.id}"
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
