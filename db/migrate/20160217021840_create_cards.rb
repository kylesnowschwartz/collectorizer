class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
