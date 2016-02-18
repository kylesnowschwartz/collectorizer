class RemoveDeckList
  def initialize(deck_list)
    @deck_list = deck_list
  end

  def call
    @deck_list.destroy!
  end
end