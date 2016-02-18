class Application
  constructor: (props = App.Components.Application.properties) ->
    @selection = m.prop(null)

  view: ->
    m("div", { class: "container" },
      m("header",
        m("h1", "Collectionizer"),
        m("a", { href: "/users/sign_out", "data-method": "delete" }, "Log out")
      ),
      m("main",
        m.component(App.Components.Collections, selection: @selection)
        m.component(App.Components.Decks, selection: @selection)
        m.component(App.Components.Selection, selection: @selection)
      )
    )

App.Components.Application =
  controller: ->
    new Application

  view: (controller) ->
    controller.view()
