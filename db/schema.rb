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

ActiveRecord::Schema[8.1].define(version: 2026_02_15_192350) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
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
    t.datetime "created_at", null: false
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

  create_table "booking_items", force: :cascade do |t|
    t.bigint "booking_id", null: false
    t.datetime "created_at", null: false
    t.text "notes"
    t.decimal "price"
    t.bigint "product_id", null: false
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_items_on_booking_id"
    t.index ["product_id"], name: "index_booking_items_on_product_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.date "booking_date"
    t.datetime "created_at", null: false
    t.bigint "customer_id", null: false
    t.date "delivery_date"
    t.text "notes"
    t.string "status"
    t.decimal "total_price"
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_bookings_on_customer_id"
  end

  create_table "business_infos", force: :cascade do |t|
    t.string "address"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "email"
    t.string "facebook_url"
    t.string "hours"
    t.string "instagram_url"
    t.string "name"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.string "whatsapp_number"
  end

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.text "address"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name"
    t.string "phone"
    t.text "preferences"
    t.datetime "updated_at", null: false
  end

  create_table "galleries", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "featured"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_galleries_on_category_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.boolean "featured"
    t.string "name"
    t.decimal "price", precision: 10, scale: 2
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.boolean "approved", default: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "phone"
    t.integer "rating"
    t.string "reviewer_name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email_address"
    t.string "password_digest"
    t.string "role"
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "booking_items", "bookings"
  add_foreign_key "booking_items", "products"
  add_foreign_key "bookings", "customers"
  add_foreign_key "galleries", "categories"
  add_foreign_key "products", "categories"
end
