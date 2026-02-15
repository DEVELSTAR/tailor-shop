class AddEmailAndPhoneToReviews < ActiveRecord::Migration[8.1]
  def change
    add_column :reviews, :email, :string
    add_column :reviews, :phone, :string
  end
end
