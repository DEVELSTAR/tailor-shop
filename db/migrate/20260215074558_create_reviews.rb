class CreateReviews < ActiveRecord::Migration[8.1]
  def change
    create_table :reviews do |t|
      t.string :reviewer_name
      t.integer :rating
      t.text :comment
      t.boolean :approved, default: false

      t.timestamps
    end
  end
end
