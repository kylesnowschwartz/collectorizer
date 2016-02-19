class Deck
  constructor: (props = {}) ->
    @deck = props.deck
    @selection = props.selection
    @collection = props.collection
    @filter = props.filter

    @filters =
      all: (card) -> true
      owned: (card) =>
        return true for owned in @collection() when owned.multiverse == card.multiverse
        false
      missing: (card) =>
        return false for owned in @collection() when owned.multiverse == card.multiverse
        true

  view: ->
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
    (card for card in @deck() when @filters[@filter()](card))
      .sort (a, b) -> a.name.localeCompare(b.name)

App.Components.Deck =
  controller: (props = {}) ->
    new Deck(props)

  view: (controller) ->
    controller.view()
