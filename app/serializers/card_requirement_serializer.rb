class CardRequirementSerializer < ActiveModel::Serializer
  attributes :card_name, :quantity_required, :quantity_owned, :multiverse
end
