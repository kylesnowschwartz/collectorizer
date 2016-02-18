class Decks
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = props.collection
    @deck = props.deck
    @decks = m.prop([])
    m.request({ method: "GET", url: "/deck_lists" }).then(@loadDecks)

  view: ->
    m("section", { class: "decks" },
      m("header",
        m("select", { onchange: @selectDeck },
          (@renderDeck(deck) for deck in @decks())
        )
      )
      m.component(App.Components.Deck, { deck: @deck, selection: @selection })
    )

  renderDeck: (deck) ->
    m("option", { value: deck.id }, deck.title)

  selectDeck: (e) =>
    id = e.target.options[e.target.selectedIndex].value
    @loadDeck(id)

  loadDecks: (decks) =>
    @decks(decks)
    @loadDeck(decks[0].id)

  loadDeck: (id) ->
    if id
      m.request({ method: "GET", url: "/deck_lists/#{id}" })
        .then(@deck)
    else
      @deck([])

App.Components.Decks =
  controller: (props = {}) ->
    new Decks(props)

  view: (controller) ->
    controller.view()
