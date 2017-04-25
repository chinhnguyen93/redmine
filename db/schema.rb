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

ActiveRecord::Schema.define(version: 20170425095351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "issues", force: :cascade do |t|
    t.string   "issue_name"
    t.string   "issue_decription"
    t.integer  "user_id"
    t.integer  "assign_id"
    t.date     "start_date"
    t.date     "due_date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "project_id"
    t.string   "status"
    t.string   "priority"
  end

  create_table "logs", force: :cascade do |t|
    t.integer  "issue_id"
    t.string   "log_description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "log_status"
    t.string   "log_priority"
    t.integer  "creator_id"
    t.integer  "update_by"
    t.index ["issue_id"], name: "index_logs_on_issue_id", using: :btree
  end

  create_table "projects", force: :cascade do |t|
    t.string   "project_name"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "relations", force: :cascade do |t|
    t.integer  "assign_id"
    t.integer  "project_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "account"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
  end

  add_foreign_key "logs", "issues"
end
