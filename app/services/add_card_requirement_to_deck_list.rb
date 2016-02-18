class AddCardRequirementToDeckList
  def initialize(deck_list, card_name, quantity_required)
    @deck_list = deck_list
    @card_name = card_name
    @quantity_required = quantity_required
  end

  def call
    @deck_list.card_requirements.create!(
      card_name: @card_name, 
      quantity_required: @quantity_required, 
      multiverse: fetch_multiverse,
      quantity_owned: quantity_owned
    )
  end

  # private

  def fetch_multiverse
    path = "https://api.deckbrew.com/mtg/cards/"
    
    card_name = @card_name.downcase.gsub(/[^-a-zA-Z\s]/, '').gsub(/[\s]/, '-')
    
    response = HTTParty.get(path + card_name)

    @multiverse = response["editions"].find { |edition| edition["multiverse_id"] > 0 }["multiverse_id"]
  end

  def quantity_owned
    @deck_list.user.cards.where(multiverse: @multiverse).count
  end
end