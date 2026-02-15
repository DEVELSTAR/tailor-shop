class CreateBookings < ActiveRecord::Migration[8.1]
  def change
    create_table :bookings do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :status
      t.date :booking_date
      t.date :delivery_date
      t.text :notes
      t.decimal :total_price

      t.timestamps
    end
  end
end
