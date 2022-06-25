class CreateAddress < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :complementary
      t.string :zip_code
      t.string :city
      t.string :addressable_type
      t.bigint :addressable_id

      t.timestamps
    end

    add_index :addresses, [:addressable_type, :addressable_id]
  end
end
