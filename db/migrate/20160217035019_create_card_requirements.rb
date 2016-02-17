class CreateCardRequirements < ActiveRecord::Migration
  def change
    create_table :card_requirements do |t|
      t.references :deck_list, index: true, foreign_key: true
      t.string :card_name
      t.integer :quantity

      t.timestamps null: false
    end
  end
end
