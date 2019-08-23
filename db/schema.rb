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

ActiveRecord::Schema.define(version: 20190823183836) do

  create_table "borrowers", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "money"
    t.string   "title"
    t.text     "description"
    t.integer  "raised"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "histories", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "lender_id"
    t.integer  "borrower_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "histories", ["borrower_id"], name: "index_histories_on_borrower_id"
  add_index "histories", ["lender_id"], name: "index_histories_on_lender_id"

  create_table "lenders", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "money"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "lendings", force: :cascade do |t|
    t.integer  "lender_id"
    t.integer  "borrower_id"
    t.integer  "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "lendings", ["borrower_id"], name: "index_lendings_on_borrower_id"
  add_index "lendings", ["lender_id"], name: "index_lendings_on_lender_id"

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
