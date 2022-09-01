class ChangePriceToIntegerOnYogaSessions < ActiveRecord::Migration[7.0]
  def change
    change_column :yoga_sessions, :price, :integer
  end
end
