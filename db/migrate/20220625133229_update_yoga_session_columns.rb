class UpdateYogaSessionColumns < ActiveRecord::Migration[7.0]
  def change
    change_table :yoga_sessions do |t|
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
    end

    remove_column :yoga_sessions, :date, :datetime
    remove_foreign_key :yoga_sessions, :users

    add_foreign_key :yoga_sessions, :teachers

    change_column :yoga_sessions, :number_booking, :integer, default: 0, null: false
  end
end
