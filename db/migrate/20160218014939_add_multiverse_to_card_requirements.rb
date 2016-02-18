class AddMultiverseToCardRequirements < ActiveRecord::Migration
  def change
    add_column :card_requirements, :multiverse, :string, null: false
  end
end
