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

ActiveRecord::Schema.define(version: 20181006042259) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "project_id"
    t.datetime "begin_date"
    t.datetime "expire_date"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.boolean  "opened",      default: true
    t.boolean  "_readonly",   default: false
  end

  add_index "courses", ["group_id", "project_id"], name: "index_courses_on_group_id_and_project_id", unique: true, using: :btree

  create_table "group_relationships", force: :cascade do |t|
    t.integer  "group_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "level",      default: 10
  end

  add_index "group_relationships", ["group_id"], name: "index_group_relationships_on_group_id", using: :btree
  add_index "group_relationships", ["user_id", "group_id"], name: "index_group_relationships_on_user_id_and_group_id", unique: true, using: :btree
  add_index "group_relationships", ["user_id"], name: "index_group_relationships_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "invitation_token"
  end

  add_index "groups", ["user_id"], name: "index_groups_on_user_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "pushed_by"
  end

  add_index "projects", ["user_id", "name", "pushed_by"], name: "index_projects_on_user_id_and_name_and_pushed_by", unique: true, using: :btree
  add_index "projects", ["user_id"], name: "index_projects_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
    t.string   "home_path"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "group_relationships", "groups"
  add_foreign_key "group_relationships", "users"
  add_foreign_key "groups", "users"
  add_foreign_key "projects", "users"
end
