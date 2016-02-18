class CardRequirementSerializer < ActiveModel::Serializer
  attributes :name, :quantity, :multiverse

  def name
    object.card_name
  end

  def quantity
    object.quantity_required
  end
end
