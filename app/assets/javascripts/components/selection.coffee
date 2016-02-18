class Selection
  constructor: (props = {}) ->
    @selection = props.selection
    @collection = props.collection
    @deck = props.deck
    @_cache = {}

  view: ->
    klass = "selection"
    klass += " empty" if @empty()
    m("section", { class: klass },
      @renderCardDetails() unless @empty(),
      m("p", "(select a card to view its details)") if @empty()
    )

  empty: ->
    !@selection()

  renderCardDetails: ->
    owned = @quantityInCollection()
    required = @quantityRequired()
    details = @cardDetails(@selection().multiverse)
    klass = "details"
    klass += if owned < required then " requirements-not-met" else " requirements-met"
    m("article", { class: klass }
      m("img", src: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=#{@selection().multiverse}&type=card"),
      m("h2", @selection().name),
      m("p", { class: "cost", innerHTML: @renderIcons(details.cost) }),
      m("p", m.trust(@renderIcons(details.text))),
      m("p", { class: "requirements" }, "You have #{owned}; you need #{required}")
    )

  renderIcons: (text) ->
    (text || "")
      .replace /{T}/g, "{tap}"
      .replace /\{([^\}]+)\}/g, (_, icon) ->
        "<i class=\"ms ms-cost ms-#{icon.toLowerCase().replace(/\W/g, "")}\"></i>"
      .replace /\n/g, "<br>"

  quantityInCollection: (card = @selection(), collection = @collection()) ->
    return owned.quantity for owned in collection when owned.multiverse == card.multiverse
    0

  quantityRequired: (card = @selection()) ->
    @quantityInCollection(card, @deck())

  cardDetails: (id) ->
    return @_cache[id] if @_cache[id]
    m.request({ method: "GET", url: "https://api.deckbrew.com/mtg/cards/?multiverseid=#{id}" })
      .then (data) =>
        m.startComputation()
        @_cache[id] = data[0] if data.length
        m.endComputation()
    {}

App.Components.Selection =
  controller: (props = {}) ->
    new Selection(props)

  view: (controller) ->
    controller.view()
