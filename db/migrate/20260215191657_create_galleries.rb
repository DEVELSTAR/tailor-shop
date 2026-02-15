class CreateGalleries < ActiveRecord::Migration[8.1]
  def change
    create_table :galleries do |t|
      t.string :title
      t.text :description
      t.references :category, null: false, foreign_key: true
      t.boolean :featured

      t.timestamps
    end
  end
end
