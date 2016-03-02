require 'rails_helper'

RSpec.describe RemoveCardRequirementFromDeckList do
  let(:user) { User.create!(email: "a@b.com", password: "password") }
  let(:deck_list) { DeckList.create!(title: "Test", user: user) }
  let(:card_requirement) { deck_list.card_requirements.create!(card_name: "Air Elemental", quantity_required: 3, multiverse: 94, quantity_owned: 0) }

  describe "#call" do
    it "removes a card requirement" do
      RemoveCardRequirementFromDeckList.new(card_requirement).call

      expect(CardRequirement.count).to eq 0
      expect(deck_list.card_requirements.count).to eq 0
    end
  end
end
