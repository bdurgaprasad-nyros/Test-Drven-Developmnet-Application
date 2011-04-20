class AddBirthdayGenderToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :gender, :string, :default => ""
    add_column :users, :birthday, :datetime
  end

  def self.down
    remove_column :users, :gender
    remove_column :users, :birthday
  end
end
