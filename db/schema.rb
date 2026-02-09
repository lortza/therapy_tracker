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

ActiveRecord::Schema[8.1].define(version: 2026_02_05_154650) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", precision: nil, null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "body_parts", force: :cascade do |t|
    t.boolean "archived", default: false
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_body_parts_on_user_id"
  end

  create_table "dummy_records", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "data", default: {}
    t.text "notes"
    t.datetime "updated_at", null: false
  end

  create_table "exercise_logs", force: :cascade do |t|
    t.bigint "body_part_id"
    t.integer "burn_rep"
    t.integer "burn_set"
    t.datetime "created_at", precision: nil, null: false
    t.bigint "exercise_id"
    t.datetime "occurred_at", precision: nil
    t.boolean "per_side", default: false
    t.text "progress_note", default: ""
    t.bigint "pt_session_log_id"
    t.integer "rep_length", default: 0
    t.integer "reps", default: 0
    t.string "resistance"
    t.integer "sets", default: 0
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["body_part_id"], name: "index_exercise_logs_on_body_part_id"
    t.index ["exercise_id"], name: "index_exercise_logs_on_exercise_id"
    t.index ["occurred_at"], name: "index_exercise_logs_on_occurred_at"
    t.index ["pt_session_log_id"], name: "index_exercise_logs_on_pt_session_log_id"
    t.index ["user_id"], name: "index_exercise_logs_on_user_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.boolean "default_per_side", default: false
    t.integer "default_rep_length"
    t.integer "default_reps"
    t.string "default_resistance"
    t.integer "default_sets"
    t.text "description"
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_exercises_on_user_id"
  end

  create_table "pain_log_quick_form_values", force: :cascade do |t|
    t.bigint "body_part_id"
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.text "pain_description"
    t.bigint "pain_id"
    t.integer "pain_level"
    t.text "trigger"
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["body_part_id"], name: "index_pain_log_quick_form_values_on_body_part_id"
    t.index ["pain_id"], name: "index_pain_log_quick_form_values_on_pain_id"
    t.index ["user_id"], name: "index_pain_log_quick_form_values_on_user_id"
  end

  create_table "pain_logs", force: :cascade do |t|
    t.bigint "body_part_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "occurred_at", precision: nil
    t.text "pain_description", default: ""
    t.bigint "pain_id"
    t.integer "pain_level"
    t.text "trigger", default: ""
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["body_part_id"], name: "index_pain_logs_on_body_part_id"
    t.index ["occurred_at"], name: "index_pain_logs_on_occurred_at"
    t.index ["pain_id"], name: "index_pain_logs_on_pain_id"
    t.index ["user_id"], name: "index_pain_logs_on_user_id"
  end

  create_table "pains", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_pains_on_user_id"
  end

  create_table "pt_homework_exercises", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.bigint "exercise_id"
    t.bigint "pt_session_log_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["exercise_id"], name: "index_pt_homework_exercises_on_exercise_id"
    t.index ["pt_session_log_id"], name: "index_pt_homework_exercises_on_pt_session_log_id"
  end

  create_table "pt_session_logs", force: :cascade do |t|
    t.bigint "body_part_id"
    t.datetime "created_at", precision: nil, null: false
    t.integer "duration"
    t.text "exercise_notes", default: ""
    t.text "homework", default: ""
    t.datetime "occurred_at", precision: nil
    t.text "questions"
    t.datetime "updated_at", precision: nil, null: false
    t.bigint "user_id"
    t.index ["body_part_id"], name: "index_pt_session_logs_on_body_part_id"
    t.index ["occurred_at"], name: "index_pt_session_logs_on_occurred_at"
    t.index ["user_id"], name: "index_pt_session_logs_on_user_id"
  end

  create_table "slit_configurations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "drops_dose_qty", null: false
    t.integer "hold_time_seconds", null: false
    t.integer "max_bottle_doses", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_slit_configurations_on_user_id"
  end

  create_table "slit_logs", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.boolean "dose_skipped"
    t.integer "doses_remaining"
    t.datetime "occurred_at"
    t.boolean "started_new_bottle", default: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["occurred_at"], name: "index_slit_logs_on_occurred_at"
    t.index ["user_id"], name: "index_slit_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.boolean "admin", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.boolean "enable_pt_session_tracking", default: false
    t.boolean "enable_slit_tracking", default: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "body_parts", "users"
  add_foreign_key "exercise_logs", "body_parts"
  add_foreign_key "exercise_logs", "exercises"
  add_foreign_key "exercise_logs", "pt_session_logs"
  add_foreign_key "exercise_logs", "users"
  add_foreign_key "exercises", "users"
  add_foreign_key "pain_log_quick_form_values", "body_parts"
  add_foreign_key "pain_log_quick_form_values", "pains"
  add_foreign_key "pain_log_quick_form_values", "users"
  add_foreign_key "pain_logs", "body_parts"
  add_foreign_key "pain_logs", "pains"
  add_foreign_key "pain_logs", "users"
  add_foreign_key "pains", "users"
  add_foreign_key "pt_homework_exercises", "exercises"
  add_foreign_key "pt_homework_exercises", "pt_session_logs"
  add_foreign_key "pt_session_logs", "body_parts"
  add_foreign_key "pt_session_logs", "users"
  add_foreign_key "slit_configurations", "users"
  add_foreign_key "slit_logs", "users"
end
