class DeckList < ActiveRecord::Base
  has_many :card_requirements

  def needed_cards
    cards_required = card_requirements.reject { |r| r.met? }

    cards_required.map do |card_requirement|
      card_name = card_requirement.card_name

      quantity_needed = [0, card_requirement.quantity - Card.where(name: card_requirement.card_name).count].max
      
      { name: card_name, quantity_needed: quantity_needed}
    end
  end
end
