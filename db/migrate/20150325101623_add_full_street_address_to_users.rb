class AddFullStreetAddressToUsers < ActiveRecord::Migration
  def change
    add_column :users, :full_street_address, :string
  end
end
