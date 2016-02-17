class CreateCardRequirements < ActiveRecord::Migration
  def change
    create_table :card_requirements do |t|
      t.references :deck_list, index: true, foreign_key: true
      t.string :card_name, null: false
      t.integer :quantity, null: false, default: 1
      t.integer :owned, null: false, default: 0

      t.timestamps null: false
    end
  end
end
