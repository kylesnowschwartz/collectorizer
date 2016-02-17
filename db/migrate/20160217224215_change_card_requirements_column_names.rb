class ChangeCardRequirementsColumnNames < ActiveRecord::Migration
  def change
    rename_column :card_requirements, :quantity, :quantity_required
    rename_column :card_requirements, :owned, :quantity_owned
  end
end
