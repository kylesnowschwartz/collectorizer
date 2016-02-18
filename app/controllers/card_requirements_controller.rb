class CardRequirementsController < ApplicationController
  def create
    AddCardRequirementToDeckList.new(
      params[:deck_list_id], 
      params[:card_name], 
      params[:quantity_required]
    ).call
  end

  def destroy
  end

  def update
  end
end
