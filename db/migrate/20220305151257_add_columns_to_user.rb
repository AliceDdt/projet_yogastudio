class AddColumnsToUser < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t|
      t.string :last_name, null: false
      t.string :first_name, null: false
      t.string :phone_number, null: false
    end
  end
end
