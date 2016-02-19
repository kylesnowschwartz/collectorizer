class AddCardRequirementToDeckList
  def initialize(deck_list, card_name, quantity_required)
    @deck_list = deck_list
    @card_name = card_name
    @quantity_required = quantity_required
  end

  def call
    fetch_multiverse_and_normalize_name

    @deck_list.card_requirements.create!(
      card_name: @card_name,
      quantity_required: @quantity_required,
      multiverse: @multiverse,
      quantity_owned: quantity_owned
    )
  end

  private

  def fetch_multiverse_and_normalize_name
    file = File.read("db/lookup.json")
    card_hash = JSON.parse(file)

    sanitized_name = ActiveSupport::Inflector.transliterate(@card_name).downcase.gsub(/[^a-z0-9\s]/i, '')

    card = card_hash[sanitized_name]
    @card_name = card["name"]
    @multiverse = card["multiverse_id"]
  end

  def quantity_owned
    @deck_list.user.cards.where(multiverse: @multiverse).count
  end
end
