class CardRequirementsController < ApplicationController
  def create
    AddCardRequirementToDeckList.new(
      params[:deck_list_id],
      params[:card_name],
      params[:quantity_required]
    ).call
  end

  def destroy
    card_requirement = CardRequirement.find(params[:id])
    deck_list = card_requirement.deck_list

    RemoveCardRequirementFromDeckList.new(card_requirement).call

    redirect_to deck_list_path(deck_list)
  end

  def update
    card_requirement = CardRequirement.find(params[:id])
    deck_list = card_requirement.deck_list

    quantity_required = params[:quantity_required]

    if quantity_required < 1
      RemoveCardRequirementFromDeckList.new(card_requirement).call
    else
      UpdateCardRequirementFromDeckList.new(card_requirement, params[:quantity_required]).call
    end

    redirect_to deck_list_path(deck_list)
  end
end
