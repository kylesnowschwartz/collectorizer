class RemoveCardRequirementFromDeckList
  def initialize(card_requirement)
    @card_requirement = card_requirement
  end

  def call
    @card_requirement.destroy!
  end
end