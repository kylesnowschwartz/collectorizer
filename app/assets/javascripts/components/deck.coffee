class Deck
  constructor: (props = {}) ->
    @deck = props.deck
    @selection = props.selection

  view: ->
    console.log @deck()
    m("ul", { class: "deck card-list" },
      (@renderCard(card) for card in @deck())
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

App.Components.Deck =
  controller: (props = {}) ->
    new Deck(props)

  view: (controller) ->
    controller.view()
