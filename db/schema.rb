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

ActiveRecord::Schema.define(:version => 20130320005221) do

  create_table "departaments", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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

  create_table "scientific_degrees", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

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

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "password_hash"
    t.string   "password_salt"
    t.string   "name"
    t.string   "surname"
    t.string   "patronymic"
    t.date     "birthday"
    t.datetime "regdate"
    t.boolean  "banned"
    t.boolean  "disabled"
    t.integer  "account_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
