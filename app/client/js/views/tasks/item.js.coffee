procrastdo.views.tasks_item = Backbone.View.extend
  template: """
    <li class="tasks-item">
      <div class="task-title">{{title}}</div>
    </li>
  """

  events: null

  initialize: ->
    @listenTo(@model, 'change', @render)
    @render()

  render: ->
    @$el.html Mustache.render(@template, @model.toJSON())