class CreateCustomers < ActiveRecord::Migration[8.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :address
      t.text :preferences

      t.timestamps
    end
  end
end
