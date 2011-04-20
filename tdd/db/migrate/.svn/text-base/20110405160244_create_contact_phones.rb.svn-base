class CreateContactPhones < ActiveRecord::Migration
  def self.up
    create_table :contact_phones do |t|
      t.string :phone_number
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contact_phones
  end
end
