procrastdo.views.tasks_show = Backbone.View.extend
  template: """
    <div class="task-show">
      <h1 class="title">{{title}}</h1>
      <p>{{description}}</p>
    </div>
  """

  events:
    'click h1': 'onHeadClick'

  initialize: ->
    @listenTo(@model, 'change', @render)

  render: ->
    @$el.append Mustache.render(@template, @model.toJSON())

  onHeadClick: ->
    console.log 'clicked on header'