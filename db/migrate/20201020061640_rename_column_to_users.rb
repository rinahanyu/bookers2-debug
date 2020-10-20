class RenameColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :postcode, :postal_code
    rename_column :users, :address_city, :city
    rename_column :users, :address_street, :street
  end
end
