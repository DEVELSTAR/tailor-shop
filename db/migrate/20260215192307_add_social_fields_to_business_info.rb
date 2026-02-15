class AddSocialFieldsToBusinessInfo < ActiveRecord::Migration[8.1]
  def change
    add_column :business_infos, :email, :string
    add_column :business_infos, :facebook_url, :string
    add_column :business_infos, :instagram_url, :string
    add_column :business_infos, :whatsapp_number, :string
  end
end
