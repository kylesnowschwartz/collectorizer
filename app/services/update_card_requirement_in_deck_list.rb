class UpdateCardRequirementInDeckList
  def initialize(card_requirement, quantity)
    @card_requirement = card_requirement
    @quantity = quantity
  end

  def call
    @card_requirement.update_attributes!(quantity: @quantity)
  end
end