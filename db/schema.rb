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

ActiveRecord::Schema[8.0].define(version: 2025_10_22_130047) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "analyses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "survey_id"
    t.integer "analysis_type"
    t.jsonb "parameters"
    t.jsonb "results"
    t.integer "status"
    t.integer "credit_cost"
    t.text "r_script"
    t.string "output_file"
    t.text "error_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "credit_transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.integer "amount"
    t.integer "transaction_type"
    t.string "description"
    t.integer "balance_after"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "analysis_id"
    t.uuid "user_id"
    t.integer "format"
    t.text "content"
    t.string "file_path"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "responses", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "survey_id"
    t.uuid "participant_id"
    t.jsonb "response_data"
    t.jsonb "demographic_data"
    t.datetime "completed_at"
    t.string "ip_address"
    t.string "device_info"
    t.boolean "is_complete"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "scales", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "doi_identifier"
    t.string "version"
    t.string "language"
    t.string "category"
    t.integer "total_items"
    t.uuid "creator_id"
    t.integer "status"
    t.jsonb "metadata"
    t.integer "usage_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "surveys", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.uuid "scale_id"
    t.uuid "user_id"
    t.integer "status"
    t.integer "distribution_mode"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "response_count"
    t.integer "target_responses"
    t.jsonb "settings"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.string "name"
    t.string "institution"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
