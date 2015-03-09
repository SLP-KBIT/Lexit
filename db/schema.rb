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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150309123723) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: true do |t|
    t.string   "isbn"
    t.text     "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", force: true do |t|
    t.integer  "user_id",                        null: false
    t.integer  "seminar_project_id",             null: false
    t.integer  "entry_type",         default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seminar_project_books", force: true do |t|
    t.integer  "book_id",                        null: false
    t.integer  "seminar_project_id",             null: false
    t.integer  "relation_type",      default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seminar_projects", force: true do |t|
    t.text     "title"
    t.text     "description"
    t.text     "target"
    t.text     "genre"
    t.integer  "project_status", default: 0, null: false
    t.integer  "data_status",    default: 0, null: false
    t.integer  "user_id",                    null: false
    t.text     "promotion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "login_name",             default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "real_name",                           null: false
    t.string   "nick_name"
    t.string   "student_code",                        null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["login_name"], name: "index_users_on_login_name", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
