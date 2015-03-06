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

ActiveRecord::Schema.define(version: 20141022151026) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "books", force: true do |t|
    t.string   "title",                                                null: false
    t.string   "subtitle"
    t.text     "summary"
    t.integer  "pages"
    t.string   "url"
    t.string   "authors",                                              null: false
    t.date     "published_on"
    t.integer  "readings",                               default: 0
    t.decimal  "average_rating", precision: 2, scale: 1, default: 0.0
    t.string   "state",                                                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover"
    t.string   "owner"
    t.string   "isbn"
    t.integer  "reviews_count",                          default: 0
    t.string   "ebook"
  end

  add_index "books", ["isbn"], name: "index_books_on_isbn", unique: true, using: :btree
  add_index "books", ["state"], name: "index_books_on_state", using: :btree

  create_table "loans", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "book_id",    null: false
    t.datetime "started_at"
    t.datetime "ends_at"
    t.datetime "closed_at"
  end

  add_index "loans", ["book_id"], name: "index_loans_on_book_id", using: :btree
  add_index "loans", ["user_id"], name: "index_loans_on_user_id", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "value",      null: false
    t.integer  "book_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ratings", ["book_id"], name: "index_ratings_on_book_id", using: :btree
  add_index "ratings", ["user_id"], name: "index_ratings_on_user_id", using: :btree

  create_table "reviews", force: true do |t|
    t.text     "body",       null: false
    t.integer  "user_id",    null: false
    t.integer  "book_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "reviews", ["book_id"], name: "index_reviews_on_book_id", using: :btree
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                               null: false
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "role",                                null: false
    t.string   "avatar"
    t.string   "authentication_token"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["role"], name: "index_users_on_role", using: :btree

end
