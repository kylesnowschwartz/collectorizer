class CardRequirement < ActiveRecord::Base
  belongs_to :desk_list

  def met?
    Card.where(name: self.card_name).count >= self.quantity
  end
end
