class CreateVanity < ActiveRecord::Migration
  def self.up
    create_table :vanities do |t|
      t.string :tag
      t.references :owner, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :vanities
  end
end
