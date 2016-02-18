class CardRequirementSerializer < ActiveModel::Serializer
  attributes :id, :card_name, :quantity_required, :quantity_owned, :multiverse
end
