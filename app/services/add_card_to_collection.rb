class AddCardToCollection
  def initialize(card_name, user)
    @card_name = card_name
    @user = user
  end

  def call
    @user.cards.create!(name: @card_name)

    update_decklists
  end

  private

  def update_decklists
    @user.decklists.each do |decklist|
      decklist.card_requirements.cards_with_name(@card_name).each do |card_requirement|
        owned = card_requirement.owned

        card_requirement.update_attributes!(owned: owned + 1)
      end
    end
  end
end