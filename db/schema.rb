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

ActiveRecord::Schema.define(version: 20140822031107) do

  create_table "questions", force: true do |t|
    t.integer  "theme_id"
    t.string   "title"
    t.integer  "points"
    t.text     "problem_statement"
    t.string   "answer"
    t.text     "explanation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "qtype",             default: ""
  end

  create_table "submissions", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.string   "status"
    t.string   "submitted_answer"
    t.datetime "time_of_submission"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "points"
    t.text     "source"
  end

  create_table "themes", force: true do |t|
    t.string   "name"
    t.text     "details"
    t.string   "database_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.string   "team_name"
    t.string   "institute"
    t.string   "contact"
    t.string   "email"
    t.string   "ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
