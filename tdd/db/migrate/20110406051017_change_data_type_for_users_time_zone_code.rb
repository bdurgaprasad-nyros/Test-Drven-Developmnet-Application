class ChangeDataTypeForUsersTimeZoneCode < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.change :time_zone_code, :string
    end

  end

  def self.down
   change_table :users do |t|
      t.change :time_zone_code, :integer
    end
  end
end
