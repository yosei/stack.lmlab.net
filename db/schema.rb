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

ActiveRecord::Schema.define(version: 20150529005723) do

  create_table "stacks", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.string   "problem",     limit: 255
    t.string   "solution",    limit: 255
    t.string   "explanation", limit: 255
    t.string   "url1",        limit: 255
    t.string   "url2",        limit: 255
    t.string   "url3",        limit: 255
    t.binary   "picture1",    limit: 16777215
    t.binary   "picture2",    limit: 16777215
    t.binary   "picture3",    limit: 16777215
    t.integer  "user_id",     limit: 4
    t.integer  "previous_id", limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "stacks_tags", force: :cascade do |t|
    t.integer  "stack_id",   limit: 4
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
