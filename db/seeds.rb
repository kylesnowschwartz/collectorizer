# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'csv'

def sanitize_card_name(name)
  name.gsub(/[^-'a-zA-Z\s]/, '')
end

CSV.foreach("./db/have_list.csv") do |row|
  Card.create!(name: row[1])
end

File.foreach("./db/brago_deck_list_1.txt") do |line_item|
  brago = DeckList.find_or_create_by(title: "Brago1")

  unless line_item == "\n"
    line_item = line_item.chomp

    quantity = line_item.split(" ")[0].to_i
    
    card_name = sanitize_card_name(line_item.split(" ")[1..-1].join(" "))
    
    CardRequirement.create!(card_name: card_name, deck_list_id: brago.id, quantity: quantity )
  end
end

["Plains", "Island", "Mountain", "Swamp", "Forest"].each do |basic_land|
  20.times { Card.create!(name: basic_land) }
end