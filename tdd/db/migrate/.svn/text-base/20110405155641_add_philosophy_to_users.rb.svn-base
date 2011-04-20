class AddPhilosophyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :religion, :string
    add_column :users, :religion_description, :text
    add_column :users, :political_view, :string
    add_column :users, :political_view_description, :text
    add_column :users, :favorite_quotes, :text
  end

  def self.down
    remove_column :users, :favorite_quotes
    remove_column :users, :political_view_description
    remove_column :users, :political_view
    remove_column :users, :religion_description
    remove_column :users, :religion
  end
end
