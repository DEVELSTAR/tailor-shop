class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :email_address
      t.index :email_address, unique: true
      t.string :password_digest

      t.timestamps
    end
  end
end
