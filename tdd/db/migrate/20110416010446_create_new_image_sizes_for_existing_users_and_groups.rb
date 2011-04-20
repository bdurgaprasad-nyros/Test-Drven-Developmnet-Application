class CreateNewImageSizesForExistingUsersAndGroups < ActiveRecord::Migration

  def self.up
    User.where("avatar IS NOT NULL").each do |u|
      if !u.avatar_url.blank? && File.exists?(u.avatar.current_path)
        u.avatar = File.open(u.avatar.current_path)
        u.save
      end
    end

    Group.where("group_image IS NOT NULL").each do |g|
      if !g.group_image_url.blank? && File.exists?(g.group_image.current_path)
        g.group_image = File.open(g.group_image.current_path)
        g.save
      end
    end
  end

  def self.down
  end
end
