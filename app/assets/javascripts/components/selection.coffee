class Selection
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = props.collection
    @deck = props.deck

  view: ->
    klass = "selection"
    klass += " empty" if @empty()
    m("section", { class: klass },
      @cardDetails() unless @empty(),
      m("p", "(select a card to view its details)") if @empty()
    )

  empty: ->
    !@selection()

  cardDetails: ->
    m("article",
      m("img", src: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{@selection().multiverse}&type=card"),
      m("h2", @selection().name),
      m("p", { class: "cost" }, @cardCost()),
      m("p", @selection().text),
      m("p", "You have #{@quantityInCollection()}; you need #{@quantityRequired()}")
    )

  cardCost: ->
    icons = []
    cost = @selection().cost
    search = /\{([^\}]+)\}/g
    while match = search.exec(cost)
      icons.push(match[1].toLowerCase())
    (m("i", class: "ms ms-#{icon}") for icon in icons)

  quantityInCollection: (card = @selection(), collection = @collection()) ->
    return owned.quantity for owned in collection when owned.multiverse == card.multiverse
    0

  quantityRequired: (card = @selection()) ->
    @quantityInCollection(card, @deck())

App.Components.Selection =
  controller: (props = {}) ->
    new Selection(props)

  view: (controller) ->
    controller.view()
