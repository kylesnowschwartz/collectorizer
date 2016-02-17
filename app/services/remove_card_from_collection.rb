class RemoveCardFromCollection
  def initialize(card, user)
    @card = card
    @card_name = card.name
    @user = user
  end

  def call
    @card.destroy!
    
    update_decklists
  end

  private

  def update_decklists
    @user.decklists.each do |decklist|
      decklist.card_requirements.cards_with_name(@card_name).each do |card_requirement|
        quantity_owned = card_requirement.quantity_owned

        card_requirement.update_attributes!(quantity_owned: quantity_owned - 1)
      end
    end
  end
end