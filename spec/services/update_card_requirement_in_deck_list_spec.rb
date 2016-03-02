require 'rails_helper'

RSpec.describe UpdateCardRequirementInDeckList do
  let(:user) { User.create!(email: "a@b.com", password: "password") }
  let(:deck_list) { DeckList.create!(title: "Test", user: user) }
  let(:card_requirement) { deck_list.card_requirements.create!(card_name: "Air Elemental", quantity_required: 3, multiverse: 94, quantity_owned: 0) }

  describe "#call" do
    context "when the quantity required is greater than 0" do
      it "updates a card requirement" do
        UpdateCardRequirementInDeckList.new(card_requirement, 2).call

        expect(CardRequirement.count).to eq 1
        expect(deck_list.card_requirements.count).to eq 1
        expect(CardRequirement.first.card_name).to eq "Air Elemental"
        expect(CardRequirement.first.quantity_required).to eq 2
        expect(CardRequirement.first.quantity_owned).to eq 0
      end
    end

    context "when the quantity required is less than or equal to 0" do
      it "removes a card requirement" do
        UpdateCardRequirementInDeckList.new(card_requirement, 0).call

        expect(CardRequirement.count).to eq 0
        expect(deck_list.card_requirements.count).to eq 0
      end
    end
  end
end
