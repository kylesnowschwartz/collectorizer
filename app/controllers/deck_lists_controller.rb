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
    CreateDeckList.new(params[:title], current_user).call

    redirect_to :show
  end

  def destroy
    decklist = DeckList.find(params[:id])

    RemoveDeckList.new(decklist).call

    redirect_to :index
  end
end
