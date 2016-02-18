class CardRequirement < ActiveRecord::Base
  belongs_to :desk_list

  scope :cards_with_multiverse, ->(multiverse) { where(multiverse: multiverse) }

  def met?
    quantity_owned >= quantity_required
  end
end
