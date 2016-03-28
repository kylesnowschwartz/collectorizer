class ParseDeckList
  attr_reader :deck_list

  def initialize(text, deck_list)
    @split_text = text.split("\n").reject(&:blank?)
    @deck_list = deck_list
  end

  def call
    @split_text.each do |line_item|
      line_item = line_item.chomp

      quantity_required = line_item.split(" ")[0].to_i

      card_name = line_item.split(" ")[1..-1].join(" ")

      AddCardRequirementToDeckList.new(deck_list, card_name, quantity_required).call
    end
  end
end