# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110419205442) do

  create_table "authentications", :force => true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_phones", :force => true do |t|
    t.string   "phone_number"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "deletion_feedbacks", :force => true do |t|
    t.integer  "user_id"
    t.text     "feeedback"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "follows", :force => true do |t|
    t.integer  "followed_id"
    t.integer  "following_id"
    t.string   "followed_type"
    t.string   "following_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "background_image"
    t.string   "group_image"
    t.integer  "broadcast_count",    :default => 0
    t.integer  "current_user_count", :default => 0
    t.boolean  "recommended",        :default => false
    t.boolean  "personal",           :default => false
  end

  add_index "groups", ["current_user_count"], :name => "index_groups_on_current_user_count"
  add_index "groups", ["recommended"], :name => "index_groups_on_recommended"

  create_table "instant_messenger_accounts", :force => true do |t|
    t.integer  "service_code"
    t.string   "screen_name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notification_preferences", :force => true do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.integer  "frequency_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notification_subscriptions", :force => true do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.integer  "notification_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "frequency_code"
  end

  create_table "notification_types", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", :force => true do |t|
    t.integer  "group_id"
    t.integer  "notification_type_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_additional_infos", :force => true do |t|
    t.integer  "user_id"
    t.string   "sports"
    t.string   "teams"
    t.string   "athletes"
    t.string   "music"
    t.string   "books"
    t.string   "movies"
    t.string   "television"
    t.string   "games"
    t.string   "other"
    t.string   "other_activities"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "inspired_by"
  end

  add_index "user_additional_infos", ["user_id"], :name => "index_user_additional_infos_on_user_id", :unique => true

  create_table "user_bans", :force => true do |t|
    t.integer  "user_id"
    t.integer  "banned_by"
    t.integer  "group_id"
    t.boolean  "permanent",    :default => false
    t.datetime "ban_end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_bans", ["ban_end_time"], :name => "index_user_bans_on_ban_end_time"
  add_index "user_bans", ["banned_by"], :name => "index_user_bans_on_banned_by"
  add_index "user_bans", ["group_id"], :name => "index_user_bans_on_group_id"
  add_index "user_bans", ["user_id"], :name => "index_user_bans_on_user_id"

  create_table "user_reports", :force => true do |t|
    t.integer  "user_id"
    t.integer  "reported_by"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_reports", ["created_at"], :name => "index_user_reports_on_created_at"
  add_index "user_reports", ["group_id"], :name => "index_user_reports_on_group_id"
  add_index "user_reports", ["reported_by"], :name => "index_user_reports_on_reported_by"
  add_index "user_reports", ["user_id"], :name => "index_user_reports_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                     :default => "",    :null => false
    t.string   "encrypted_password",         :limit => 128, :default => "",    :null => false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                             :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gender",                                    :default => ""
    t.datetime "date_of_birth"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "avatar"
    t.integer  "secret_question_code"
    t.string   "secret_question_answer"
    t.integer  "language_code"
    t.string   "time_zone"
    t.string   "home_town"
    t.string   "current_town"
    t.string   "interested_in_code"
    t.text     "bio"
    t.integer  "relationship_status_code"
    t.string   "religion"
    t.text     "religion_description"
    t.string   "political_view"
    t.text     "political_view_description"
    t.text     "favorite_quotes"
    t.string   "street_address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.integer  "current_group_id"
    t.boolean  "is_broadcasting",                           :default => false
    t.boolean  "banned",                                    :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["current_group_id"], :name => "index_users_on_current_group_id"
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "vanities", :force => true do |t|
    t.string   "tag"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
