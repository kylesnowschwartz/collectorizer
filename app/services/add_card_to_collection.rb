class AddCardToCollection
  def initialize(card_name, user, multiverse = nil)
    @card_name = card_name
    @user = user
    @multiverse = multiverse
  end

  def call
    fetch_multiverse_and_normalize_name
    @user.cards.create!(name: @card_name, multiverse: @multiverse)

    update_decklists
  end

  private

  def fetch_multiverse_and_normalize_name
    card = MTG::Card.where(name: "\"#{@card_name}\"").all.find { |card| card.multiverse_id.present? }

    @card_name = card.name
    @multiverse = card.multiverse_id
  end

  def update_decklists
    @user.deck_lists.each do |deck_list|
      deck_list.card_requirements.cards_with_multiverse(@multiverse).each do |card_requirement|
        quantity_owned = card_requirement.quantity_owned

        card_requirement.update_attributes!(quantity_owned: quantity_owned + 1)
      end
    end
  end
end
