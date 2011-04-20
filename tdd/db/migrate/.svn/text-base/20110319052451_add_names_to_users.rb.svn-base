class AddNamesToUsers < ActiveRecord::Migration
  def self.up
      add_column :users, :first_name, :string
      add_column :users, :last_name, :string
      rename_column :users, :birthday, :date_of_birth
  end

  def self.down
    remove_column :users, :first_name, :string
    remove_column :users, :last_name, :string
    rename_column :users, :birthday, :date_of_birth
    
  end
end
