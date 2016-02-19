require 'rails_helper'

RSpec.describe CreateDeckList do
  let(:user) { User.create!(email: "a@b.com", password: "password") }

  describe "#call" do
    it "creates a deck list with the specified title" do
      deck_list = CreateDeckList.new("Test", user).call

      expect(deck_list.title).to eq "Test"
      expect(DeckList.last).to eq deck_list
    end
  end
end
