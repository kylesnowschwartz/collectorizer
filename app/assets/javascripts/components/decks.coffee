class Decks
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = props.collection
    @deck = props.deck
    @decks = m.prop([])
    @filter = m.prop("all")
    @dialog = props.dialog
    m.request({ method: "GET", url: "/deck_lists" }).then(@loadDecks)

  view: ->
    m("section", { class: "decks" },
      m("header",
        m("h3", "Select a deck"),
        m("select", { onchange: @selectDeck },
          (@renderDeck(deck) for deck in @decks()),
          m("option", { value: "new_deck"}, "Add a Deck")
        ),
        m("div", { class: "filters", onchange: @filterChanged },
          (@renderFilter(filter) for filter in ["all", "acquired", "missing"])
        )
      )
      m.component(App.Components.Deck, { deck: @deck, selection: @selection, filter: @filter, collection: @collection })
    )

  addNewDeck: =>
    @deckTitle ?= m.prop("")
    @dialog(
      m("div", { id: "dialogContainer" },
        m(".dialog", m(".dialogContent", [
          m("h2", "Add deck")
          m("form", { onsubmit: @submitNewDeck },
            m("textarea", { oninput: m.withAttr("value", @deckTitle), type: "text", id: "deckTitle", placeholder: "Add a deck...", value: @deckTitle() }),
            m("button", { type: "submit" }, "Add")
          )
          m("a", {
            href: "#"
            onclick: => @dialog(false)
          }, "Cancel")
        ])
        )
      )
    )

  submitNewDeck: (e) =>
    e.preventDefault()
    console.log("WHOOHOOOOO")
    m.request
      method: "POST"
      url: "/decks"
      data:
        deck:
          title: @deckTitle()
    .then (cards) =>
      @deck(new App.Models.Collection(cards))
      @deckTitle("")

  renderDeck: (deck) ->
    m("option", { value: deck.id }, deck.title)

  renderFilter: (filter) ->
    [
      m("input", { type: "radio", name: "filter", value: filter, checked: @filter() == filter, id: "filter_#{filter}" }),
      m("label", { for: "filter_#{filter}" }, filter)
    ]

  filterChanged: (e) =>
    @filter(e.target.value)

  selectDeck: (e) =>
    id = e.target.options[e.target.selectedIndex].value
    if id == "new_deck" 
      @addNewDeck()
    else
      @loadDeck(id)

  loadDecks: (decks) =>
    @decks(decks)
    @loadDeck(decks[0].id)

  loadDeck: (id) ->
    if id
      m.request({ method: "GET", url: "/deck_lists/#{id}" })
        .then (cards) => @deck(new App.Models.Collection(cards))
    else
      @deck(new App.Models.Collection)


App.Components.Decks =
  controller: (props = {}) ->
    new Decks(props)

  view: (controller) ->
    controller.view()
