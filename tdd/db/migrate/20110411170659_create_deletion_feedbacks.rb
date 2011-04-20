class CreateDeletionFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :deletion_feedbacks do |t|
      t.integer :user_id
      t.text :feeedback
      t.timestamps
    end
  end

  def self.down
    drop_table :deletion_feedbacks
  end
end
