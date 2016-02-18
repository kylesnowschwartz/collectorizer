class CardCollection
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def cards
    user
      .cards
      .group_by(&:multiverse)
      .map { |mid, cards| CardWithQuantity.new(cards.first, cards.length) }
  end
end
