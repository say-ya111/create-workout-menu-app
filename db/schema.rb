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

ActiveRecord::Schema.define(version: 2020_06_14_091621) do

  create_table "menus", force: :cascade do |t|
    t.integer "user_id"
    t.integer "type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type_id"], name: "index_menus_on_type_id"
    t.index ["user_id", "type_id"], name: "index_menus_on_user_id_and_type_id", unique: true
    t.index ["user_id"], name: "index_menus_on_user_id"
  end

  create_table "muscle_parts", force: :cascade do |t|
    t.integer "user_id"
    t.date "last_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "recovery_span"
    t.integer "part_id"
    t.index ["part_id"], name: "index_muscle_parts_on_part_id"
    t.index ["user_id", "part_id"], name: "index_muscle_parts_on_user_id_and_part_id", unique: true
    t.index ["user_id"], name: "index_muscle_parts_on_user_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "muscle_part_id"
    t.integer "type_id"
    t.index ["muscle_part_id"], name: "index_parts_on_muscle_part_id"
    t.index ["type_id"], name: "index_parts_on_type_id"
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "part_id"
    t.integer "user_id", default: 0
    t.index ["id"], name: "index_types_on_id_and_user_id", unique: true
    t.index ["part_id"], name: "index_types_on_part_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
