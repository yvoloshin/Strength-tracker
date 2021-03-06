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

ActiveRecord::Schema.define(version: 20190225024228) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "completed_sets", force: :cascade do |t|
    t.integer  "reps"
    t.integer  "exercise_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "load"
    t.integer  "weight_unit_id"
  end

  create_table "exercise_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "sets"
    t.integer  "reps"
    t.integer  "workout_type_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "load"
    t.string   "url"
    t.integer  "weight_unit_id"
  end

  add_index "exercise_types", ["workout_type_id"], name: "index_exercise_types_on_workout_type_id", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "workout_id"
    t.integer  "exercise_type_id"
  end

  add_index "exercises", ["exercise_type_id"], name: "index_exercises_on_exercise_type_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "username"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "weight_units", force: :cascade do |t|
    t.string  "name"
    t.decimal "conversion_factor_to_lb", precision: 10, scale: 4
  end

  create_table "workout_types", force: :cascade do |t|
    t.string   "type_name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "user_id"
    t.boolean  "public"
    t.text     "description"
    t.boolean  "is_visible"
  end

  add_index "workout_types", ["user_id"], name: "index_workout_types_on_user_id", using: :btree

  create_table "workouts", force: :cascade do |t|
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "user_id"
    t.integer  "workout_type_id"
    t.string   "workout_type_name"
  end

  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id", using: :btree
  add_index "workouts", ["workout_type_id"], name: "index_workouts_on_workout_type_id", using: :btree

end
