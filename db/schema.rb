# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130525015413) do

  create_table "api_keys", :force => true do |t|
    t.string   "key"
    t.integer  "user_id"
    t.datetime "expiry_date"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "api_keys", ["user_id"], :name => "index_api_keys_on_user_id"

  create_table "comment_votes", :force => true do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.integer  "vote"
    t.datetime "vote_time"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "comment_votes", ["comment_id"], :name => "index_comment_votes_on_lecturer_comment_id"
  add_index "comment_votes", ["user_id"], :name => "index_comment_votes_on_user_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "body"
    t.datetime "posttime"
    t.boolean  "anonymously"
    t.integer  "mark"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "lecturer_id"
  end

  add_index "comments", ["lecturer_id"], :name => "index_comments_on_lecturer_id"
  add_index "comments", ["user_id"], :name => "index_comments_on_user_id"

  create_table "departaments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "feedbacks", :force => true do |t|
    t.integer  "student_id"
    t.integer  "subject_subscription_id"
    t.datetime "time"
    t.datetime "created_at",              :null => false
    t.datetime "updated_at",              :null => false
  end

  add_index "feedbacks", ["student_id"], :name => "index_feedbacks_on_student_id"
  add_index "feedbacks", ["subject_subscription_id"], :name => "index_feedbacks_on_subject_subscription_id"

  create_table "lecturers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "departament_id"
    t.integer  "scientific_degree_id"
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "confirm_level",        :default => 0
  end

  add_index "lecturers", ["departament_id"], :name => "index_lecturers_on_departament_id"
  add_index "lecturers", ["scientific_degree_id"], :name => "index_lecturers_on_scientific_degree_id"
  add_index "lecturers", ["user_id"], :name => "index_lecturers_on_user_id"

  create_table "private_messages", :force => true do |t|
    t.integer  "sender_id"
    t.integer  "receiver_id"
    t.string   "title"
    t.text     "body"
    t.datetime "sendtime"
    t.boolean  "read"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
    t.boolean  "sender_delete_flag",   :default => false
    t.boolean  "receiver_delete_flag", :default => false
  end

  add_index "private_messages", ["receiver_id"], :name => "index_private_messages_on_receiver_id"
  add_index "private_messages", ["sender_id"], :name => "index_private_messages_on_sender_id"

  create_table "questions", :force => true do |t|
    t.string   "text"
    t.integer  "type"
    t.boolean  "required"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scientific_degrees", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "specialties", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "students", :force => true do |t|
    t.integer  "user_id"
    t.integer  "specialty_id"
    t.integer  "course"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "students", ["specialty_id"], :name => "index_students_on_specialty_id"
  add_index "students", ["user_id"], :name => "index_students_on_user_id"

  create_table "subject_subscriptions", :force => true do |t|
    t.integer  "subject_id"
    t.integer  "lecturer_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "subject_subscriptions", ["lecturer_id"], :name => "index_subject_subscriptions_on_lecturer_id"
  add_index "subject_subscriptions", ["subject_id"], :name => "index_subject_subscriptions_on_subject_id"

  create_table "subjects", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "departament_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "subjects", ["departament_id"], :name => "index_subjects_on_departament_id"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.datetime "regdate"
    t.boolean  "banned"
    t.boolean  "disabled"
    t.integer  "account_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "removed",       :default => false
  end

end
