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

ActiveRecord::Schema.define(version: 2021_04_22_174849) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "captures", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id", null: false
    t.uuid "pokemon_id", null: false
    t.datetime "captured_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["pokemon_id"], name: "index_captures_on_pokemon_id"
    t.index ["user_id", "pokemon_id"], name: "index_captures_on_user_id_and_pokemon_id", unique: true
    t.index ["user_id"], name: "index_captures_on_user_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.uuid "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "pokemon", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.integer "external_id", null: false
    t.string "image_url", null: false
    t.datetime "imported_at", null: false
    t.uuid "pokemon_import_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["external_id"], name: "index_pokemon_on_external_id", unique: true
    t.index ["image_url"], name: "index_pokemon_on_image_url", unique: true
    t.index ["name"], name: "index_pokemon_on_name", unique: true
    t.index ["pokemon_import_id"], name: "index_pokemon_on_pokemon_import_id", unique: true
    t.index ["slug"], name: "index_pokemon_on_slug", unique: true
  end

  create_table "pokemon_imports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.json "data", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["url"], name: "index_pokemon_imports_on_url", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "auth_token", null: false
    t.string "slug", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", null: false
    t.index ["auth_token"], name: "index_users_on_auth_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "captures", "pokemon"
  add_foreign_key "captures", "users"
  add_foreign_key "pokemon", "pokemon_imports"
end
