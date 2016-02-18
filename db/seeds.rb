# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

user = User.first

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
  20.times { AddCardToCollection.new(basic_land, user).call }
end