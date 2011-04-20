class AddBasicInformationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :home_town, :string
    add_column :users, :current_town, :string
    add_column :users, :interested_in_code, :string
    add_column :users, :bio, :text
  end

  def self.down
    remove_column :users, :bio
    remove_column :users, :interested_in_code
    remove_column :users, :current_town
    remove_column :users, :home_town
  end
end
