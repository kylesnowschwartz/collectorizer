class Decks
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = props.collection
    @deck = props.deck
    @decks = m.prop([])
    @filter = m.prop("all")
    m.request({ method: "GET", url: "/deck_lists" }).then(@loadDecks)

  view: ->
    m("section", { class: "decks" },
      m("header",
        m("h3", "Select a deck"),
        m("select", { onchange: @selectDeck },
          (@renderDeck(deck) for deck in @decks())
        ),
        m("div", { class: "filters", onchange: @filterChanged },
          (@renderFilter(filter) for filter in ["all", "acquired", "missing"])
        )
      )
      m.component(App.Components.Deck, { deck: @deck, selection: @selection, filter: @filter, collection: @collection })
    )

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
