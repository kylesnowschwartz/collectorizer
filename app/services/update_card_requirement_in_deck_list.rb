class UpdateCardRequirementInDeckList
  def initialize(card_requirement, quantity_required)
    @card_requirement = card_requirement
    @quantity_required = quantity_required
  end

  def call
    @card_requirement.update_attributes!(quantity_required: @quantity_required)
  end
end