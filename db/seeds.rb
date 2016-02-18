require 'csv'

# You'll need to create a user before running this seedfile
user = User.create!(email: "kyle.snowschwartz@gmail.com", password: "password")

decklist = CreateDeckList.new("Brago1", user).call

CSV.foreach("./db/have_list.csv") do |row|
  AddCardToCollection.new(row[1], user).call
end

File.foreach("./db/brago_deck_list_1.txt") do |line_item|
  unless line_item == "\n"
    line_item = line_item.chomp

    quantity_required = line_item.split(" ")[0].to_i
    
    card_name = line_item.split(" ")[1..-1].join(" ")

    AddCardRequirementToDeckList.new(decklist, card_name, quantity_required).call
  end
end

["Plains", "Island", "Mountain", "Swamp", "Forest"].each do |basic_land|
  10.times { AddCardToCollection.new(basic_land, user).call }
end