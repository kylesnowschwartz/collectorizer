class Application
  constructor: (props = App.Components.Application.properties) ->
    @selection = m.prop(null)
    @collection = m.prop(new App.Models.Collection)
    @deck = m.prop(new App.Models.Collection)

  view: ->
    m("div", { class: "container" },
      m("header",
        m("h1", "Collectionizer"),
        m("a", { href: "/users/sign_out", "data-method": "delete" }, "Log out")
      ),
      m("main",
        m.component(App.Components.Collections, selection: @selection, collection: @collection, deck: @deck)
        m.component(App.Components.Decks, selection: @selection, collection: @collection, deck: @deck)
        m.component(App.Components.Selection, selection: @selection, collection: @collection, deck: @deck)
      )
    )

App.Components.Application =
  controller: ->
    new Application

  view: (controller) ->
    controller.view()
