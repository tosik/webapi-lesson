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

ActiveRecord::Schema.define(version: 20150120073505) do

  create_table "activities", force: :cascade do |t|
    t.text     "text"
    t.integer  "boss_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "activities", ["boss_id"], name: "index_activities_on_boss_id"

  create_table "bosses", force: :cascade do |t|
    t.integer  "hp"
    t.integer  "number_of_actions"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.text     "hate_table"
  end

  create_table "characters", force: :cascade do |t|
    t.string   "job"
    t.integer  "hp"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "characters", ["user_id"], name: "index_characters_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
