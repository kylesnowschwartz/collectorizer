class Selection
  constructor: (props = {}) ->
    @selection = props.selection

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
    )

  cardCost: ->
    icons = []
    cost = @selection().cost
    search = /\{([^\}]+)\}/g
    while match = search.exec(cost)
      icons.push(match[1].toLowerCase())
    (m("i", class: "ms ms-#{icon}") for icon in icons)

App.Components.Selection =
  controller: (props = {}) ->
    new Selection(props)

  view: (controller) ->
    controller.view()
