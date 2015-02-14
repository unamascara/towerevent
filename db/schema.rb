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

ActiveRecord::Schema.define(version: 20150214141855) do

  create_table "accesses", force: true do |t|
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: true do |t|
    t.string   "body"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["commentable_id", "commentable_type"], name: "index_comments_on_commentable_id_and_commentable_type"

  create_table "events", force: true do |t|
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "eventsource_id"
    t.string   "eventsource_type"
  end

  add_index "events", ["eventable_id", "eventable_type"], name: "index_events_on_eventable_id_and_eventable_type"
  add_index "events", ["eventsource_id", "eventsource_type"], name: "index_events_on_eventsource_id_and_eventsource_type"

  create_table "projects", force: true do |t|
    t.string   "name"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teamusers", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teamusers", ["role_id"], name: "index_teamusers_on_role_id"
  add_index "teamusers", ["team_id"], name: "index_teamusers_on_team_id"
  add_index "teamusers", ["user_id"], name: "index_teamusers_on_user_id"

  create_table "todolists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "todos", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "body"
    t.datetime "due"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "finished_at"
    t.integer  "todolist_id"
    t.integer  "position"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
