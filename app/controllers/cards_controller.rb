class CardsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    AddCardToCollection.new(params[:card_name], current_user).call
  end

  def destroy
    card = Card.find(params[:id])

    RemoveCardFromCollection.new(card, current_user).call
  end
end
