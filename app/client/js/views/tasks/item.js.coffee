procrastdo.views.tasks_item = Backbone.View.extend
  tagName: 'li'
  className: 'task-item'
  template: """
    <div class="task-title">{{title}}</div>
  """

  events: null

  initialize: ->
    @listenTo(@model, 'change', @render)
    @render()

  render: ->
    @$el.html Mustache.render(@template, @model.toJSON())