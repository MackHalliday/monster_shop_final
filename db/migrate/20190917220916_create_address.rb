class CreateAddress < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :address_type
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zipcode
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
