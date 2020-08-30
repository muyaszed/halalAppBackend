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

ActiveRecord::Schema.define(version: 2020_08_28_204602) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_bookmarks_on_restaurant_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "check_ins", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_check_ins_on_restaurant_id"
    t.index ["user_id"], name: "index_check_ins_on_user_id"
  end

  create_table "facebook_auths", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "email"
    t.string "uid"
    t.string "oauth_token"
    t.string "fb_avatar"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_facebook_auths_on_user_id"
  end

  create_table "halal_verifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "restaurant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "certificate", default: false
    t.boolean "confirmation", default: false
    t.boolean "logo", default: false
    t.index ["restaurant_id"], name: "index_halal_verifications_on_restaurant_id"
    t.index ["user_id"], name: "index_halal_verifications_on_user_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "avatar_uri"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.text "desc"
    t.float "latitude"
    t.float "longitude"
    t.string "cuisine"
    t.string "web"
    t.string "start"
    t.string "end"
    t.string "cover_uri"
    t.string "address"
    t.string "city"
    t.string "postcode"
    t.string "country"
    t.string "location"
    t.string "contact_number"
    t.jsonb "soc_med", default: "{}", null: false
    t.boolean "family_friendly"
    t.boolean "surau"
    t.boolean "disabled_accessibility"
    t.string "sub_header"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "restaurant_id"
    t.string "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo_uri"
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "var", null: false
    t.text "value"
    t.string "target_type", null: false
    t.integer "target_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["target_type", "target_id", "var"], name: "index_settings_on_target_type_and_target_id_and_var", unique: true
    t.index ["target_type", "target_id"], name: "index_settings_on_target_type_and_target_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "profiles", "users"
  add_foreign_key "restaurants", "users"
end
