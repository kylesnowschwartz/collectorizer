class Decks
  constructor: (props = {}) ->
    @selection = props.selection
    @deck = m.prop([
      {
        name: "Blackcleave Goblin",
        multiverse: 194297,
        text: "Haste Infect (This creature deals damage to creatures in the form of -1/-1 counters and to players in the form of poison counters.)",
        cost: "{3}{B}"
      },
      {
        name: "Bloodbond Vampire",
        multiverse: 401826,
        text: "Whenever you gain life, put a +1/+1 counter on Bloodbond Vampire.",
        cost: "{2}{B}{B}"
      }
    ])

  view: ->
    m("section", { class: "decks" },
      m.component(App.Components.Deck, { deck: @deck, selection: @selection })
    )

App.Components.Decks =
  controller: (props = {}) ->
    new Decks(props)

  view: (controller) ->
    controller.view()
