class Collections
  constructor: (props = {}) ->
    @selection = props.selection

  view: ->
    m("section", { class: "collections" })

App.Components.Collections =
  controller: (props = {}) ->
    new Collections(props)

  view: (controller) ->
    controller.view()
