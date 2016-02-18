class CardRequirementSerializer < ActiveModel::Serializer
  attributes :card_name, :quantity, :multiverse

  def quantity
    object.quantity_required
  end
end
