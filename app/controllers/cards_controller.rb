class CardsController < ApplicationController
  before_action :authenticate_user!

  def index
    respond_to do |format|
      format.html
      format.json { render json: CardCollection.new(current_user).cards }
    end
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
