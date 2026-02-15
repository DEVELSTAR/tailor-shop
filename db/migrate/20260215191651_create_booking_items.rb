class CreateBookingItems < ActiveRecord::Migration[8.1]
  def change
    create_table :booking_items do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :price
      t.text :notes

      t.timestamps
    end
  end
end
