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

ActiveRecord::Schema[7.0].define(version: 2022_03_12_164718) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "complementary"
    t.string "zip_code"
    t.string "city"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "yoga_session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bookings_on_user_id"
    t.index ["yoga_session_id"], name: "index_bookings_on_yoga_session_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.text "short_description", null: false
    t.text "long_description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128, null: false
    t.string "last_name", null: false
    t.string "first_name", null: false
    t.string "phone_number", null: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

  create_table "yoga_sessions", force: :cascade do |t|
    t.date "date", null: false
    t.time "time", null: false
    t.integer "number_participants", null: false
    t.integer "number_booking", null: false
    t.float "price", null: false
    t.bigint "course_id"
    t.bigint "teacher_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_yoga_sessions_on_course_id"
    t.index ["teacher_id"], name: "index_yoga_sessions_on_teacher_id"
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "bookings", "users"
  add_foreign_key "bookings", "yoga_sessions"
  add_foreign_key "yoga_sessions", "courses"
  add_foreign_key "yoga_sessions", "users", column: "teacher_id"
end
