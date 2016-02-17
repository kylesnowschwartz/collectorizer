class AddCardRequirementToDeckList
  def initialize(decklist, card_name, quantity_required)
    @decklist = decklist
    @card_name = card_name
    @quantity_required = quantity_required
  end

  def call
    @decklist.card_requirements.create!(card_name: @card_name, quantity_required: @quantity_required, quantity_owned: quantity_owned)
  end

  private

  def quantity_owned
    Card.where(name: @card_name).count
  end
end