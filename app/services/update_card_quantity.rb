class UpdateCardQuantity
  attr_reader :user, :params

  def initialize(params, user)
    @params = params
    @user = user
  end

  def call
    Card.transaction do
      if (delta = quantity - cards.size) > 0
        delta.times { add_card }
      elsif delta < 0
        cards[0, -delta].map { |card| remove_card(card) }
      end

      user.cards.reload
    end
  end

  private

  def cards
    @cards ||= user.cards.with_multiverse_id(params[:multiverse])
  end

  def quantity
    [params[:quantity].to_i, 0].max
  end

  def add_card
    AddCardToCollection.new(params[:name], user, params[:multiverse]).call
  end

  def remove_card(card)
    RemoveCardFromCollection.new(card, user).call
  end
end
