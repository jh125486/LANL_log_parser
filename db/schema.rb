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

ActiveRecord::Schema.define(version: 20151108220128) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"
  enable_extension "hstore"

  create_table "log_lines", force: :cascade do |t|
    t.text     "message"
    t.integer  "number"
    t.integer  "log_id"
    t.integer  "node_id"
    t.string   "process"
    t.string   "pid"
    t.datetime "timestamp",  null: false
    t.integer  "priority"
    t.text     "comment"
    t.string   "error_type"
    t.hstore   "info"
  end

  add_index "log_lines", ["log_id"], name: "index_log_lines_on_log_id", using: :btree
  add_index "log_lines", ["node_id"], name: "index_log_lines_on_node_id", using: :btree

  create_table "logs", force: :cascade do |t|
    t.string   "file"
    t.string   "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "log_lines", "logs"
  add_foreign_key "log_lines", "nodes"
end
