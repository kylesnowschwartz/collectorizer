class DeckListsController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.json { render json: current_user.deck_lists }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: DeckList.find(params[:id]).card_requirements }
    end
  end

  def create
    new_deck = CreateDeckList.new(params[:title], current_user).call

    ParseDeckList.new(params[:list], new_deck).call

    respond_to do |format|
      format.html
      format.json { render json: DeckList.find(new_deck.id).card_requirements }
    end
  end

  def destroy
    decklist = DeckList.find(params[:id])

    RemoveDeckList.new(decklist).call

    respond_to do |format|
      format.html
      format.json { render json: current_user.deck_lists }
    end
  end
end
