class AddMultiverseToCard < ActiveRecord::Migration
  def change
    add_column :cards, :multiverse, :string, null: false
  end
end
