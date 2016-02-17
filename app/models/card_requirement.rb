class CardRequirement < ActiveRecord::Base
  belongs_to :desk_list

  scope :cards_with_name, ->(card_name) { where(card_name: card_name) }

  def met?
    Card.where(name: self.card_name).count >= self.quantity
  end
end
