class AddContactInformationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :street_address, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip_code, :string
  end

  def self.down
    remove_column :users, :zip_code
    remove_column :users, :state
    remove_column :users, :city
    remove_column :users, :street_address
  end
end
