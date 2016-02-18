class DeckListsController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    CreateDeckList.new(params[:title], current_user).call
  end

  def destroy
    decklist = DeckList.find(params[:id])

    RemoveDeckList.new(decklist).call
  end
end
