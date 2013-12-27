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

ActiveRecord::Schema.define(version: 20131227110358) do

  create_table "books", force: true do |t|
    t.string   "title",                                                null: false
    t.string   "subtitle"
    t.text     "summary"
    t.integer  "pages"
    t.string   "url"
    t.string   "authors",                                              null: false
    t.date     "published_on"
    t.integer  "readings"
    t.decimal  "average_rating", precision: 6, scale: 2, default: 0.0
    t.string   "state",                                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover"
  end

  add_index "books", ["state"], name: "index_books_on_state"

  create_table "loans", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "book_id",    null: false
    t.datetime "started_at"
    t.datetime "ends_at"
    t.datetime "closed_at"
  end

  add_index "loans", ["book_id"], name: "index_loans_on_book_id"
  add_index "loans", ["user_id"], name: "index_loans_on_user_id"

  create_table "users", force: true do |t|
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "email",                          null: false
    t.string   "encrypted_password", limit: 128, null: false
    t.string   "confirmation_token", limit: 128
    t.string   "remember_token",     limit: 128, null: false
    t.string   "first_name",                     null: false
    t.string   "last_name",                      null: false
    t.string   "role",                           null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"
  add_index "users", ["role"], name: "index_users_on_role"

end
