class Deck
  constructor: (props = {}) ->
    @deck = props.deck
    @selection = props.selection

  view: ->
    m("ul", { class: "deck" },
      (@renderCard(card) for card in @deck())
    )

  renderCard: (card) ->
    klass = "card"
    klass += " selected" if @selected(card)
    m("li", { class: klass, onclick: => @selection(card) }, card.name)

  selected: (card) ->
    @selection()?.multiverseid == card.multiverseid

App.Components.Deck =
  controller: (props = {}) ->
    new Deck(props)

  view: (controller) ->
    controller.view()
