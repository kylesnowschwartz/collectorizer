class AddUserToDeckLists < ActiveRecord::Migration
  def change
    add_reference :deck_lists, :user, index: true
  end
end
