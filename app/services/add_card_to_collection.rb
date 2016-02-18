class AddCardToCollection
  def initialize(card_name, user)
    @card_name = card_name
    @user = user
  end

  def call
    @user.cards.create!(name: @card_name, multiverse: fetch_multiverse)

    update_decklists
  end

  private

  def fetch_multiverse
    path = "https://api.deckbrew.com/mtg/cards/"
    
    card_name = @card_name.downcase.gsub(/[^a-zA-Z\s]/, '').gsub(/[\s]/, '-')
    
    response = HTTParty.get(path + card_name)

    @multiverse = response["editions"].first["multiverse_id"].to_s
  end

  def update_decklists
    @user.decklists.each do |decklist|
      decklist.card_requirements.cards_with_multiverse(@multiverse).each do |card_requirement|
        quantity_owned = card_requirement.quantity_owned

        card_requirement.update_attributes!(quantity_owned: quantity_owned + 1)
      end
    end
  end
end