class CreateBusinessInfos < ActiveRecord::Migration[8.1]
  def change
    create_table :business_infos do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :hours
      t.text :description

      t.timestamps
    end
  end
end
