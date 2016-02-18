class Collections
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = props.collection

  view: ->
    m("section", { class: "collections" },
      m.component(App.Components.Collection, { selection: @selection, collection: @collection })
    )

App.Components.Collections =
  controller: (props = {}) ->
    new Collections(props)

  view: (controller) ->
    controller.view()
