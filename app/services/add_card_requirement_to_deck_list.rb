class AddCardRequirementToDeckList
  def initialize(decklist, card_name, quantity)
    @decklist = decklist
    @card_name = card_name
    @quantity = quantity
  end

  def call
    @decklist.card_requirements.create!(card_name: @card_name, quantity: @quantity, owned: amount_owned)
  end

  private

  def amount_owned
    Card.where(name: @card_name).count
  end
end