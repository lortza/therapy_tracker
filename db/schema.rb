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

ActiveRecord::Schema.define(version: 2019_03_26_025021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "exercise_logs", force: :cascade do |t|
    t.text "target_body_part", default: ""
    t.integer "sets", default: 0
    t.integer "reps", default: 0
    t.datetime "datetime_occurred"
    t.integer "current_pain_level", default: 0
    t.string "current_pain_frequency", default: ""
    t.text "progress_note", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "exercise_id"
    t.index ["exercise_id"], name: "index_exercise_logs_on_exercise_id"
    t.index ["user_id"], name: "index_exercise_logs_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "pain_logs", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "datetime_occurred"
    t.string "target_body_part", default: ""
    t.integer "pain_level"
    t.text "pain_description", default: ""
    t.text "trigger", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pain_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "exercise_logs", "exercises"
  add_foreign_key "exercise_logs", "users"
  add_foreign_key "exercises", "users"
  add_foreign_key "pain_logs", "users"
end
