procrastdo.views.tasks_item = Backbone.View.extend
  tagName: 'li'
  className: 'task-item'
  template: """
    <span class="task-done task-done-no">No</span>
    <span class="task-title">{{title}}</a>
  """

  events: null

  initialize: ->
    @listenTo(@model, 'change', @render)
    @render()

  render: ->
    @$el.html Mustache.render(@template, @model.toJSON())