class CreateYogaSession < ActiveRecord::Migration[7.0]
  def change
    create_table :yoga_sessions do |t|
      t.date :date, null: false
      t.time :time, null: false
      t.integer :number_participants, null: false
      t.integer :number_booking, null: false
      t.float :price, null: false

      t.belongs_to :course, foreign_key: true
      t.belongs_to :teacher, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end 
