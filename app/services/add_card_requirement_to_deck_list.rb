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
      quantity_owned: quantity_owned,
      multiverse: fetch_multiverse
    )
  end

  private

  def fetch_multiverse
    path = "https://api.deckbrew.com/mtg/cards/"
    
    card_name = @card_name.downcase.gsub(/[^a-zA-Z\s]/, '').gsub(/[\s]/, '-')
    
    response = HTTParty.get(path + card_name)

    @multiverse = response["editions"].first["multiverse_id"].to_s
  end

  def quantity_owned
    Card.where(multiverse: @multiverse).count
  end
end