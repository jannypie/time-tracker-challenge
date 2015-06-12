TimeTracker.Views.TimeEntries ||= {}

class TimeTracker.Views.TimeEntries.NewView extends Backbone.View
  template: JST["backbone/templates/time_entries/new"]

  events:
    "change #select-company"  : "getCompanyData",
    "click #start-timing"     : "setStartedAt",
    "click #stop-timing"      : "setDuration",
    "submit #new-time_entry"  : "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  getCompanyData: () ->
    $('option#default-company').remove();
    company_id = $('#select-company').val();
    $(TimeTracker.Companies).each (i,el) =>
      if el.id == parseInt company_id
        @populateProjects(el)
        @populateTasks(el)

  populateProjects: (el) ->
    selectEl = $('#select-project');
    selectEl.empty()
    $(el.Projects).each (i,el) =>
      selectEl.append('<option value="' + el.id + '">' + el.name + '</option>')
      selectEl.removeAttr('disabled')

  populateTasks: (el) ->
    selectEl = $('#select-task');
    selectEl.empty()
    $(el.Tasks).each (i,el) =>
      selectEl.append('<option value="' + el.id + '">' + el.name + '</option>')
      selectEl.removeAttr('disabled')

  setStartedAt: (e) ->
    e.preventDefault()
    e.stopPropagation()

    $('#started_at').val(Date.now())
    $('#start-timing').html('<i class="fi-pause"></i>').attr('id','stop-timing').removeClass('start')

  setDuration: (e) ->
    e.preventDefault()
    e.stopPropagation()

    $('#duration').val(Date.now() - $('#started_at').val())
    $('#stop-timing').attr('disabled','disabled')
    $('#submit-entry').removeAttr('disabled')

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")
    @model.set({
      project_id: $('form #select-project').val(),
      task_id: $('form #select-task').val(),
      duration: $('form #duration').val(),
      started_at: $('form #started_at').val()
    })

    @collection.create(@model.toJSON(),
      success: (time_entry) =>
        @model = time_entry
        console.log @model
        window.location = "/time_entries"

      error: (time_entry, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    @$el.html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
