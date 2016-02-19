class App.Models.Collection extends Array
  constructor: (cards = []) ->
    super
    @splice(0, 0, cards...)

  quantity: (multiverse) ->
    return card.quantity for card in this when card.multiverse == multiverse
    0
