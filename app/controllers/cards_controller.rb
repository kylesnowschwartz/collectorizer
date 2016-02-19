class CardsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: CardCollection.new(current_user).cards }
    end
  end

  def create
    AddCardToCollection.new(card_params[:name], current_user).call

    redirect_to cards_path
  end

  def destroy
    card = Card.find(params[:id])

    RemoveCardFromCollection.new(card, current_user).call

    redirect_to cards_path
  end

  private

  def card_params
    params.require(:card).permit(:name)
  end
end
