class CreateDeckLists < ActiveRecord::Migration
  def change
    create_table :deck_lists do |t|
      t.string :title, null: false

      t.timestamps null: false
    end
  end
end
