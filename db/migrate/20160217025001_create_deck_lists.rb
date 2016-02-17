class CreateDeckLists < ActiveRecord::Migration
  def change
    create_table :deck_lists do |t|
      t.string :title

      t.timestamps null: false
    end
  end
end
