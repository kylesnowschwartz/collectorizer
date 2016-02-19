require 'csv'

# You'll need to create a user before running this seedfile
# user = User.create!(email: "kyle.snowschwartz@gmail.com", password: "password")

# CSV.foreach("./db/have_list.csv") do |row|
#   p row[1]

#   AddCardToCollection.new(row[1], user).call
# end

# deck_list = CreateDeckList.new("Brago1", user).call

# File.foreach("./db/brago_deck_list_1.txt") do |line_item|
#   unless line_item == "\n"
#     line_item = line_item.chomp

#     quantity_required = line_item.split(" ")[0].to_i

#     card_name = line_item.split(" ")[1..-1].join(" ")

#     AddCardRequirementToDeckList.new(deck_list, card_name, quantity_required).call
#   end
# end

# deck_list_two = CreateDeckList.new("Zedruu1", user).call

# File.foreach("./db/zedruu_sample.txt") do |line_item|
#   unless line_item == "\n"
#     line_item = line_item.chomp

#     quantity_required = line_item.split(" ")[0].to_i

#     card_name = line_item.split(" ")[1..-1].join(" ")

#     AddCardRequirementToDeckList.new(deck_list_two, card_name, quantity_required).call
#   end
# end

# ["Plains", "Island", "Mountain", "Swamp", "Forest"].each do |basic_land|
#   10.times { AddCardToCollection.new(basic_land, user).call }
# end

gods_deck_list = CreateDeckList.new("Gods1", user).call

File.foreach("./db/five-color-god.txt") do |line_item|
  unless line_item == "\n"
    line_item = line_item.chomp

    quantity_required = line_item.split(" ")[0].to_i

    card_name = line_item.split(" ")[1..-1].join(" ")

    AddCardRequirementToDeckList.new(gods_deck_list, card_name, quantity_required).call
  end
end
