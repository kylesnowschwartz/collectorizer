class Deck
  constructor: (props = {}) ->
    @deck = props.deck
    @selection = props.selection
    @collection = props.collection
    @filter = props.filter

    @filters =
      all: (card) -> true
      acquired: (card) =>
        @collection().quantity(card.multiverse) >= @deck().quantity(card.multiverse)
      missing: (card) =>
        @collection().quantity(card.multiverse) < @deck().quantity(card.multiverse)

  view: ->
    m("ul", { class: "deck card-list" },
      (@renderCard(card) for card in @sortedDeck())
    )

  renderCard: (card) ->
    klass = "card"
    klass += " selected" if @selected(card)
    m("li",
      { class: klass, onclick: => @selection(card) },
      "#{@count(card)} × #{card.name}"
    )

  selected: (card) ->
    @selection()?.multiverse == card.multiverse

  sortedDeck: ->
    (card for card in @deck() when @filters[@filter()](card))
      .sort (a, b) -> a.name.localeCompare(b.name)

  count: (card) ->
    quantity = card.quantity
    owned = Math.min(quantity, @collection().quantity(card.multiverse))
    switch @filter()
      when "acquired" then owned
      when "missing" then quantity - owned
      else quantity

App.Components.Deck =
  controller: (props = {}) ->
    new Deck(props)

  view: (controller) ->
    controller.view()
