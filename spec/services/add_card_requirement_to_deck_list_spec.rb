require 'rails_helper'

RSpec.describe AddCardRequirementToDeckList do
  let(:user) { User.create!(email: "a@b.com", password: "password") }
  let(:deck_list) { DeckList.create!(title: "Test", user: user) }

  describe "#call" do
    it "creates a card requirement with a given card name, quantity required, multiverse id and quantity owned" do
      AddCardRequirementToDeckList.new(deck_list, "Air Elemental", 4).call

      expect(CardRequirement.count).to eq 1
      expect(deck_list.card_requirements.count).to eq 1
      expect(CardRequirement.first.card_name).to eq "Air Elemental"
      expect(CardRequirement.first.quantity_required).to eq 4
      expect(CardRequirement.first.quantity_owned).to eq 0
    end
  end
end
