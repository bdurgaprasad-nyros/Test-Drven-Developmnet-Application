class ChangeTimezoneFieldName < ActiveRecord::Migration
  def self.up
    rename_column :users, :time_zone_code, :time_zone

  end

  def self.down
    rename_column :users, :time_zone, :time_zone_code


  end
end
