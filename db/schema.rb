# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_07_08_111948) do
  create_table "balances", force: :cascade do |t|
    t.integer "amount"
    t.integer "user_id", null: false
    t.string "formatted_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["user_id"], name: "index_balances_on_user_id"
  end

  create_table "closings", force: :cascade do |t|
    t.integer "amount"
    t.integer "user_id", null: false
    t.string "formatted_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["user_id"], name: "index_closings_on_user_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.integer "collection"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.integer "amount"
    t.index ["user_id"], name: "index_collections_on_user_id"
  end

  create_table "disbursments", force: :cascade do |t|
    t.integer "disbursment"
    t.integer "user_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_disbursments_on_user_id"
  end

  create_table "openings", force: :cascade do |t|
    t.integer "amount"
    t.integer "user_id", null: false
    t.string "formatted_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["user_id"], name: "index_openings_on_user_id"
  end

  create_table "rates", force: :cascade do |t|
    t.integer "amount"
    t.integer "user_id", null: false
    t.string "formatted_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
    t.index ["user_id"], name: "index_rates_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  add_foreign_key "balances", "users"
  add_foreign_key "closings", "users"
  add_foreign_key "collections", "users"
  add_foreign_key "disbursments", "users"
  add_foreign_key "openings", "users"
  add_foreign_key "rates", "users"
end
