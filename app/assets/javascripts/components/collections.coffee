class Collections
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = props.collection
    @searchString = m.prop("")

  view: ->
    m("section", { class: "collections" },
      m("header",
        m("h3", "My collection"),
        m("form", { onsubmit: @addCard },
          m("input", { onchange: m.withAttr("value", @searchString), type: "text", id: "cardName", placeholder: "Add a card…", value: @searchString() }),
          m("button", { type: "submit" }, "Add")
        )
      ),
      m.component(App.Components.Collection, { selection: @selection, collection: @collection })
    )

  addCard: (e) =>
    e.preventDefault()
    e.target.cardName.disabled = true
    m.request
      method: "POST"
      url: "/cards"
      data:
        card:
          name: @searchString()
    .then (cards) =>
      @collection(new App.Models.Collection(cards))
      e.target.cardName.disabled = false
      @searchString("")

App.Components.Collections =
  controller: (props = {}) ->
    new Collections(props)

  view: (controller) ->
    controller.view()
