class CardWithQuantity
  attr_reader :quantity, :card
  delegate :name, :multiverse, to: :card

  def initialize(card, quantity = 1)
    @card = card
    @quantity = quantity
  end

  # support method for ActiveModelSerializer
  alias :read_attribute_for_serialization :send
end
