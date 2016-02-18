class Deck
  constructor: (props = {}) ->
    @deck = props.deck
    @selection = props.selection
    @collection = props.collection

  view: ->
    console.log @deck()
    m("ul", { class: "deck card-list" },
      (@renderCard(card) for card in @sortedDeck())
    )

  renderCard: (card) ->
    klass = "card"
    klass += " selected" if @selected(card)
    m("li",
      { class: klass, onclick: => @selection(card) },
      "#{card.quantity} × #{card.name}"
    )

  selected: (card) ->
    @selection()?.multiverse == card.multiverse

  sortedDeck: ->
    @deck().sort (a, b) -> a.name.localeCompare(b.name)

App.Components.Deck =
  controller: (props = {}) ->
    new Deck(props)

  view: (controller) ->
    controller.view()
