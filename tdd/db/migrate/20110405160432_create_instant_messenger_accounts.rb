class CreateInstantMessengerAccounts < ActiveRecord::Migration
  def self.up
    create_table :instant_messenger_accounts do |t|
      t.integer :service_code
      t.string :screen_name
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :instant_messenger_accounts
  end
end
