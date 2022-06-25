class CreateTeacher < ActiveRecord::Migration[7.0]
  def change
    create_table :teachers do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.text :bio
      t.timestamps
    end
  end
end
