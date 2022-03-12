class CreateAddress < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :complementary
      t.string :zip_code
      t.string :city

      t.timestamps
    end
  end
end
