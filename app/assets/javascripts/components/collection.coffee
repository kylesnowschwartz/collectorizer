class Collection
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = m.prop([])
    m.request({ method: "GET", url: "/cards" }).then(@collection)

  view: ->
    m("ul", { class: "collection card-list" },
      (@renderCard(card) for card in @groupedCollection())
    )

  renderCard: (card) ->
    klass = "card"
    klass += " selected" if @selected(card)
    m("li",
      {
        class: klass,
        key: card.multiverse,
        "data-multiverse-id": card.multiverse,
        onclick: => @selection(card)
      },
      "#{card.quantity} × #{card.name}"
    )

  groupedCollection: ->
    collection = {}
    for card in @collection() || []
      unless collection[card.multiverse]
        collection[card.multiverse] = $.extend(card, quantity: 0)
      collection[card.multiverse].quantity += 1
    (card for own multiverse, card of collection)

  selected: (card) ->
    @selection()?.multiverse == card.multiverse

App.Components.Collection =
  controller: (props = {}) ->
    new Collection(props)

  view: (controller) ->
    controller.view()
