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

ActiveRecord::Schema[8.0].define(version: 2025_09_22_193110) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "contestants", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.string "name"
    t.boolean "eliminated"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_contestants_on_season_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.bigint "season_id", null: false
    t.integer "number"
    t.date "air_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_episodes_on_season_id"
  end

  create_table "overall_picks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "season_id", null: false
    t.bigint "winner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["season_id"], name: "index_overall_picks_on_season_id"
    t.index ["user_id", "season_id"], name: "index_overall_picks_on_user_id_and_season_id", unique: true
    t.index ["user_id"], name: "index_overall_picks_on_user_id"
    t.index ["winner_id"], name: "index_overall_picks_on_winner_id"
  end

  create_table "picks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "episode_id", null: false
    t.bigint "star_baker_id"
    t.bigint "technical_winner_id"
    t.bigint "handshake_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_picks_on_episode_id"
    t.index ["handshake_id"], name: "index_picks_on_handshake_id"
    t.index ["star_baker_id"], name: "index_picks_on_star_baker_id"
    t.index ["technical_winner_id"], name: "index_picks_on_technical_winner_id"
    t.index ["user_id", "episode_id"], name: "index_picks_on_user_id_and_episode_id", unique: true
    t.index ["user_id"], name: "index_picks_on_user_id"
  end

  create_table "results", force: :cascade do |t|
    t.bigint "episode_id", null: false
    t.bigint "star_baker_id"
    t.bigint "technical_winner_id"
    t.bigint "handshake_id"
    t.bigint "eliminated_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eliminated_id"], name: "index_results_on_eliminated_id"
    t.index ["episode_id"], name: "index_results_on_episode_id", unique: true
    t.index ["handshake_id"], name: "index_results_on_handshake_id"
    t.index ["star_baker_id"], name: "index_results_on_star_baker_id"
    t.index ["technical_winner_id"], name: "index_results_on_technical_winner_id"
  end

  create_table "seasons", force: :cascade do |t|
    t.integer "year"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "winner_contestant_id"
    t.index ["winner_contestant_id"], name: "index_seasons_on_winner_contestant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false, null: false
    t.index ["is_admin"], name: "index_users_on_is_admin"
  end

  add_foreign_key "contestants", "seasons"
  add_foreign_key "episodes", "seasons"
  add_foreign_key "overall_picks", "contestants", column: "winner_id"
  add_foreign_key "overall_picks", "seasons"
  add_foreign_key "overall_picks", "users"
  add_foreign_key "picks", "contestants", column: "handshake_id"
  add_foreign_key "picks", "contestants", column: "star_baker_id"
  add_foreign_key "picks", "contestants", column: "technical_winner_id"
  add_foreign_key "picks", "episodes"
  add_foreign_key "picks", "users"
  add_foreign_key "results", "contestants", column: "eliminated_id"
  add_foreign_key "results", "contestants", column: "handshake_id"
  add_foreign_key "results", "contestants", column: "star_baker_id"
  add_foreign_key "results", "contestants", column: "technical_winner_id"
  add_foreign_key "results", "episodes"
  add_foreign_key "seasons", "contestants", column: "winner_contestant_id"
end
