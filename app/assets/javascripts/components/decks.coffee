class Decks
  constructor: (props = {}) ->
    @selection = props.selection
    @decks = m.prop([])
    m.request({ method: "GET", url: "/deck_lists" }).then(@loadDecks)

    @deck = m.prop([
      {
        name: "Blackcleave Goblin",
        multiverse: 194297,
        text: "Haste Infect (This creature deals damage to creatures in the form of -1/-1 counters and to players in the form of poison counters.)",
        cost: "{3}{B}"
      },
      {
        name: "Bloodbond Vampire",
        multiverse: 401826,
        text: "Whenever you gain life, put a +1/+1 counter on Bloodbond Vampire.",
        cost: "{2}{B}{B}"
      }
    ])

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
    m("option", { value: deck.id, selected: deck.id == @deckId() }, deck.title)

  selectDeck: (e) ->
    @deckId(e.target.options[e.target.selectedIndex].value)

  loadDecks: (decks) =>
    @decks(decks)
    @deckId(decks[0].id) if decks.length && !@deckId()

  deckId: (value) ->
    @_deckId = value if value?
    @_deckId || @decks()[0]?.id

App.Components.Decks =
  controller: (props = {}) ->
    new Decks(props)

  view: (controller) ->
    controller.view()
