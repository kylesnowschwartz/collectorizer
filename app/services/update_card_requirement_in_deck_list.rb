class UpdateCardRequirementInDeckList
  def initialize(card_requirement, quantity_required)
    @card_requirement = card_requirement
    @quantity_required = quantity_required
  end

  def call
    CardRequirement.transaction do
      if @quantity_required > 0
        update_card_requirement
      elsif @quantity_required <= 0
        remove_card_requirement
      end

      deck_list.reload
    end
  end

  private

  def deck_list
    DeckList.find(@card_requirement.deck_list_id)
  end

  def update_card_requirement
    @card_requirement.update_attributes!(quantity_required: @quantity_required)
  end

  def remove_card_requirement
    RemoveCardRequirementFromDeckList.new(@card_requirement).call
  end
end
