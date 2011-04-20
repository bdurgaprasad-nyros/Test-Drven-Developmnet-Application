class AddBackgroundImageAndGroupImageToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :background_image, :string
    add_column :groups, :group_image, :string
  end

  def self.down
    remove_column :groups, :background_image
    remove_column :groups, :group_image
  end
end
