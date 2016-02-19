class App.Models.Collection extends Array
  constructor: (cards = []) ->
    super
    @splice(0, 0, cards...)

  quantity: (multiverse) ->
    return card.quantity for card in this when card.multiverse == multiverse
    0

  setQuantity: (card, quantity) ->
    if quantity > 0
      for existing in this when existing.multiverse == card.multiverse
        existing.quantity = quantity
        return
      @push($.extend({}, card, { quantity }))
    else
      @remove(card.multiverse)

  remove: (multiverse) ->
    i = 0
    while i < @length
      if this[i].multiverse == multiverse
        @splice(i, 1)
      else
        i++
