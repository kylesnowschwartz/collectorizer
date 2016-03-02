require 'rails_helper'

RSpec.describe RemoveDeckList do
  let(:deck_list) { DeckList.create!(title: "Test") }

  describe "#call" do
    it "destroys given deck list" do
      RemoveDeckList.new(deck_list).call

      expect(deck_list).to be_destroyed
      expect(DeckList.count).to eq 0
    end
  end
end
