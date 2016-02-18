class Collection
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = props.collection
    m.request({ method: "GET", url: "/cards" }).then(@collection)

  view: ->
    m("ul", { class: "collection card-list" },
      (@renderCard(card) for card in @sortedCollection())
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

  sortedCollection: ->
    @collection().sort (a, b) -> a.name.localeCompare(b.name)

  selected: (card) ->
    @selection()?.multiverse == card.multiverse

App.Components.Collection =
  controller: (props = {}) ->
    new Collection(props)

  view: (controller) ->
    controller.view()
