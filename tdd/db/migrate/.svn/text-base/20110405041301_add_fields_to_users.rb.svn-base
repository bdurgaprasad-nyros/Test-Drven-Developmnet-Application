class AddFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :secret_question_code, :integer
    add_column :users, :secret_question_answer, :string
    add_column :users, :language_code, :integer
    add_column :users, :time_zone_code, :integer
  end

  def self.down
    remove_column :users, :time_zone_code
    remove_column :users, :language_code
    remove_column :users, :secret_question_answer
    remove_column :users, :secret_question_code
  end
end
