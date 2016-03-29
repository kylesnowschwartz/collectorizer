class AddCardRequirementToDeckList
  def initialize(deck_list, card_name, quantity_required)
    @deck_list = deck_list
    @card_name = card_name
    @quantity_required = quantity_required
  end

  def call
    fetch_multiverse_and_normalize_name

    @deck_list.card_requirements.create!(
      card_name: @card_name,
      quantity_required: @quantity_required,
      multiverse: @multiverse,
      quantity_owned: quantity_owned
    )
  end

  private

  def fetch_multiverse_and_normalize_name
    card = MTG::Card.where(name: @card_name).all.find { |card| card.multiverse_id.present? }

    @card_name = card.name
    @multiverse = card.multiverse_id
  end

  def quantity_owned
    @deck_list.user.cards.where(multiverse: @multiverse).count
  end
end
