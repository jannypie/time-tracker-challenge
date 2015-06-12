TimeTracker.Views.Tasks ||= {}

class TimeTracker.Views.Tasks.NewView extends Backbone.View
  template: JST["backbone/templates/tasks/new"]

  events:
    "submit #new-task": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    @model.set({
      task_id: $('form #task').val(),
      task: $('form #task').val(),
      started_at: Date.now()
    })

    @collection.create(@model.toJSON(),
      success: (task) =>
        @model = task
        window.location.hash = "/#{@model.id}"

      error: (task, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
