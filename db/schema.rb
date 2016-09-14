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

ActiveRecord::Schema.define(version: 20160623110339) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.string   "resource_id",   limit: 255,   null: false
    t.string   "resource_type", limit: 255,   null: false
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string  "address",         limit: 255
    t.integer "member_id",       limit: 4
    t.integer "location_id",     limit: 4
    t.integer "area_id",         limit: 4
    t.integer "city_id",         limit: 4
    t.boolean "address_type"
    t.boolean "current_working"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   limit: 255
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "areas", force: :cascade do |t|
    t.string  "area",      limit: 255,                          null: false
    t.integer "city_id",   limit: 4
    t.decimal "longitude",             precision: 10, scale: 6
    t.decimal "latitude",              precision: 10, scale: 6
  end

  add_index "areas", ["area"], name: "index_areas_on_area", using: :btree
  add_index "areas", ["city_id", "area"], name: "index_areas_on_city_id_and_area", using: :btree

  create_table "areas_champaigns", id: false, force: :cascade do |t|
    t.integer "champaign_id", limit: 4, null: false
    t.integer "area_id",      limit: 4, null: false
  end

  add_index "areas_champaigns", ["area_id", "champaign_id"], name: "index_areas_champaigns_on_area_id_and_champaign_id", using: :btree
  add_index "areas_champaigns", ["champaign_id", "area_id"], name: "index_areas_champaigns_on_champaign_id_and_area_id", using: :btree

  create_table "areas_members", id: false, force: :cascade do |t|
    t.integer "area_id",   limit: 4, null: false
    t.integer "member_id", limit: 4, null: false
  end

  create_table "areas_statuses", force: :cascade do |t|
    t.integer "area_id",         limit: 4
    t.integer "category_id",     limit: 4
    t.integer "members_counter", limit: 4
  end

  create_table "areas_users", id: false, force: :cascade do |t|
    t.integer "user_id", limit: 4, null: false
    t.integer "area_id", limit: 4, null: false
  end

  create_table "assets", force: :cascade do |t|
    t.string  "type",                    limit: 255
    t.integer "assetable_id",            limit: 4
    t.string  "assetable_type",          limit: 255
    t.string  "attachment_file_name",    limit: 255
    t.string  "attachment_content_type", limit: 255
    t.integer "attachment_file_size",    limit: 4
  end

  create_table "banks", force: :cascade do |t|
    t.string "title", limit: 255
  end

  create_table "bpo_venders", force: :cascade do |t|
    t.string "name",     limit: 255, null: false
    t.string "phone",    limit: 255
    t.string "address",  limit: 255
    t.string "auth_key", limit: 255
  end

  create_table "bpo_venders_phones", id: false, force: :cascade do |t|
    t.integer "bpo_vender_id", limit: 4, null: false
    t.integer "phone_id",      limit: 4, null: false
  end

  add_index "bpo_venders_phones", ["bpo_vender_id", "phone_id"], name: "index_bpo_venders_phones_on_bpo_vender_id_and_phone_id", using: :btree
  add_index "bpo_venders_phones", ["phone_id", "bpo_vender_id"], name: "index_bpo_venders_phones_on_phone_id_and_bpo_vender_id", using: :btree

  create_table "calls", force: :cascade do |t|
    t.integer  "demand_id",        limit: 4
    t.integer  "member_id",        limit: 4
    t.integer  "phone_id",         limit: 4
    t.integer  "call_status",      limit: 4
    t.integer  "call_response",    limit: 4
    t.datetime "call_datetime"
    t.integer  "call_duration",    limit: 4
    t.integer  "call_priority",    limit: 4
    t.integer  "voice_message_id", limit: 4
    t.integer  "ivr_message_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "call_id",          limit: 255
    t.integer  "hangup_cause_id",  limit: 4
    t.integer  "retries",          limit: 4
    t.integer  "champaign_id",     limit: 4
  end

  create_table "candidate_statuses", force: :cascade do |t|
    t.string "title", limit: 255, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string  "title",   limit: 255,                null: false
    t.boolean "active",              default: true
    t.integer "segment", limit: 4
  end

  create_table "categories_champaigns", id: false, force: :cascade do |t|
    t.integer "champaign_id", limit: 4, null: false
    t.integer "category_id",  limit: 4, null: false
  end

  add_index "categories_champaigns", ["category_id", "champaign_id"], name: "index_categories_champaigns_on_category_id_and_champaign_id", using: :btree
  add_index "categories_champaigns", ["champaign_id", "category_id"], name: "index_categories_champaigns_on_champaign_id_and_category_id", using: :btree

  create_table "categories_emp_types", id: false, force: :cascade do |t|
    t.integer "emp_type_id", limit: 4, null: false
    t.integer "category_id", limit: 4, null: false
  end

  add_index "categories_emp_types", ["category_id", "emp_type_id"], name: "index_categories_emp_types_on_category_id_and_emp_type_id", using: :btree
  add_index "categories_emp_types", ["emp_type_id", "category_id"], name: "index_categories_emp_types_on_emp_type_id_and_category_id", using: :btree

  create_table "categories_jobs", id: false, force: :cascade do |t|
    t.integer "category_id", limit: 4, null: false
    t.integer "job_id",      limit: 4, null: false
  end

  add_index "categories_jobs", ["category_id", "job_id"], name: "index_categories_jobs_on_category_id_and_job_id", using: :btree
  add_index "categories_jobs", ["job_id", "category_id"], name: "index_categories_jobs_on_job_id_and_category_id", using: :btree

  create_table "categories_members", id: false, force: :cascade do |t|
    t.integer "member_id",   limit: 4, null: false
    t.integer "category_id", limit: 4, null: false
  end

  add_index "categories_members", ["category_id", "member_id"], name: "index_categories_members_on_category_id_and_member_id", using: :btree
  add_index "categories_members", ["member_id", "category_id"], name: "index_categories_members_on_member_id_and_category_id", using: :btree

  create_table "categories_users", id: false, force: :cascade do |t|
    t.integer "user_id",     limit: 4,                null: false
    t.integer "category_id", limit: 4,                null: false
    t.boolean "alert",                 default: true
  end

  create_table "champaigns", force: :cascade do |t|
    t.string   "name",       limit: 255,             null: false
    t.integer  "attempts",   limit: 4,   default: 0
    t.integer  "interested", limit: 4,   default: 0
    t.integer  "pulses",     limit: 4,   default: 0
    t.integer  "cost",       limit: 4,   default: 0
    t.string   "sound_file", limit: 255
    t.integer  "status",     limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "champaigns_cities", id: false, force: :cascade do |t|
    t.integer "champaign_id", limit: 4, null: false
    t.integer "city_id",      limit: 4, null: false
  end

  add_index "champaigns_cities", ["champaign_id", "city_id"], name: "index_champaigns_cities_on_champaign_id_and_city_id", using: :btree
  add_index "champaigns_cities", ["city_id", "champaign_id"], name: "index_champaigns_cities_on_city_id_and_champaign_id", using: :btree

  create_table "champaigns_locations", id: false, force: :cascade do |t|
    t.integer "champaign_id", limit: 4, null: false
    t.integer "location_id",  limit: 4, null: false
  end

  add_index "champaigns_locations", ["champaign_id", "location_id"], name: "index_champaigns_locations_on_champaign_id_and_location_id", using: :btree
  add_index "champaigns_locations", ["location_id", "champaign_id"], name: "index_champaigns_locations_on_location_id_and_champaign_id", using: :btree

  create_table "cities", force: :cascade do |t|
    t.string "city", limit: 255, null: false
  end

  add_index "cities", ["city"], name: "index_cities_on_city", using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "demands", force: :cascade do |t|
    t.integer  "category_id",             limit: 4
    t.integer  "location_id",             limit: 4
    t.integer  "area_id",                 limit: 4
    t.integer  "city_id",                 limit: 4
    t.integer  "max_salary",              limit: 4
    t.integer  "no_of_helpers_to_search", limit: 4
    t.integer  "last_area",               limit: 4
    t.integer  "last_member",             limit: 4,   default: 0
    t.integer  "interested",              limit: 4,   default: 0
    t.integer  "connected",               limit: 4,   default: 0
    t.integer  "status",                  limit: 4,   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "referred",                limit: 4,   default: 0
    t.integer  "callback",                limit: 4,   default: 0
    t.string   "sound_file",              limit: 255
    t.integer  "user_id",                 limit: 4
    t.boolean  "to_all",                              default: false
    t.integer  "hire_type",               limit: 4
    t.string   "description",             limit: 255
  end

  create_table "distance_matrices", force: :cascade do |t|
    t.integer "city_id",        limit: 4
    t.integer "area_id",        limit: 4
    t.integer "nearby_area_id", limit: 4
    t.float   "distance",       limit: 24
  end

  create_table "educations", force: :cascade do |t|
    t.string "education", limit: 255, null: false
  end

  create_table "educations_members", id: false, force: :cascade do |t|
    t.integer "member_id",    limit: 4, null: false
    t.integer "education_id", limit: 4, null: false
  end

  add_index "educations_members", ["education_id", "member_id"], name: "index_educations_members_on_education_id_and_member_id", using: :btree
  add_index "educations_members", ["member_id", "education_id"], name: "index_educations_members_on_member_id_and_education_id", using: :btree

  create_table "emp_types", force: :cascade do |t|
    t.string   "title",      limit: 255, null: false
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "emp_types_industries", id: false, force: :cascade do |t|
    t.integer "emp_type_id", limit: 4, null: false
    t.integer "industry_id", limit: 4, null: false
  end

  add_index "emp_types_industries", ["emp_type_id", "industry_id"], name: "index_emp_types_industries_on_emp_type_id_and_industry_id", using: :btree
  add_index "emp_types_industries", ["industry_id", "emp_type_id"], name: "index_emp_types_industries_on_industry_id_and_emp_type_id", using: :btree

  create_table "emp_types_members", id: false, force: :cascade do |t|
    t.integer "member_id",   limit: 4, null: false
    t.integer "emp_type_id", limit: 4, null: false
  end

  add_index "emp_types_members", ["emp_type_id", "member_id"], name: "index_emp_types_members_on_emp_type_id_and_member_id", using: :btree
  add_index "emp_types_members", ["member_id", "emp_type_id"], name: "index_emp_types_members_on_member_id_and_emp_type_id", using: :btree

  create_table "experiences", force: :cascade do |t|
    t.integer "years",     limit: 4, default: 0, null: false
    t.integer "member_id", limit: 4
    t.integer "job_id",    limit: 4
  end

  create_table "freetexts", force: :cascade do |t|
    t.integer "type_of",          limit: 4,   null: false
    t.integer "member_id",        limit: 4
    t.integer "user_id",          limit: 4
    t.string  "text",             limit: 255, null: false
    t.integer "category_tag_id",  limit: 4
    t.integer "emp_type_tag_id",  limit: 4
    t.integer "education_tag_id", limit: 4
  end

  create_table "freetexts_members", id: false, force: :cascade do |t|
    t.integer "freetext_id", limit: 4, null: false
    t.integer "member_id",   limit: 4, null: false
  end

  add_index "freetexts_members", ["freetext_id", "member_id"], name: "index_freetexts_members_on_freetext_id_and_member_id", using: :btree
  add_index "freetexts_members", ["member_id", "freetext_id"], name: "index_freetexts_members_on_member_id_and_freetext_id", using: :btree

  create_table "freetexts_users", id: false, force: :cascade do |t|
    t.integer "freetext_id", limit: 4, null: false
    t.integer "user_id",     limit: 4, null: false
  end

  add_index "freetexts_users", ["freetext_id", "user_id"], name: "index_freetexts_users_on_freetext_id_and_user_id", using: :btree
  add_index "freetexts_users", ["user_id", "freetext_id"], name: "index_freetexts_users_on_user_id_and_freetext_id", using: :btree

  create_table "hangup_causes", id: false, force: :cascade do |t|
    t.integer "id",          limit: 4
    t.string  "enumeration", limit: 255
    t.string  "description", limit: 255
  end

  create_table "industries", force: :cascade do |t|
    t.string   "title",      limit: 255, null: false
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interview_comments", force: :cascade do |t|
    t.string   "title",        limit: 255, null: false
    t.integer  "interview_id", limit: 4,   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "interview_reasons", force: :cascade do |t|
    t.string  "title",               limit: 255, null: false
    t.integer "interview_status_id", limit: 4
    t.integer "priority",            limit: 4
    t.boolean "active"
  end

  create_table "interview_reasons_statuses", force: :cascade do |t|
    t.integer "interview_reason_id", limit: 4
    t.integer "interview_status_id", limit: 4
  end

  create_table "interview_statuses", force: :cascade do |t|
    t.string  "title",    limit: 255, null: false
    t.integer "position", limit: 4
  end

  create_table "interviews", force: :cascade do |t|
    t.integer  "user_id",             limit: 4,                   null: false
    t.integer  "member_id",           limit: 4,                   null: false
    t.date     "interview_date"
    t.time     "interview_time"
    t.integer  "status",              limit: 4
    t.string   "description",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "interview_reason_id", limit: 4
    t.integer  "interview_status_id", limit: 4
    t.boolean  "billing",                         default: false
    t.string   "sid",                 limit: 255
    t.string   "recording_url",       limit: 255
    t.integer  "call_status",         limit: 4
    t.integer  "category_id",         limit: 4
  end

  create_table "jobs", force: :cascade do |t|
    t.string "job", limit: 255, null: false
  end

  create_table "jobs_members", id: false, force: :cascade do |t|
    t.integer "member_id", limit: 4, null: false
    t.integer "job_id",    limit: 4, null: false
  end

  add_index "jobs_members", ["job_id", "member_id"], name: "index_jobs_members_on_job_id_and_member_id", using: :btree
  add_index "jobs_members", ["member_id", "job_id"], name: "index_jobs_members_on_member_id_and_job_id", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string "language", limit: 255, null: false
  end

  create_table "languages_members", id: false, force: :cascade do |t|
    t.integer "member_id",   limit: 4, null: false
    t.integer "language_id", limit: 4, null: false
  end

  add_index "languages_members", ["language_id", "member_id"], name: "index_languages_members_on_language_id_and_member_id", using: :btree
  add_index "languages_members", ["member_id", "language_id"], name: "index_languages_members_on_member_id_and_language_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string  "location", limit: 255, null: false
    t.integer "area_id",  limit: 4
    t.integer "city_id",  limit: 4
  end

  add_index "locations", ["area_id", "location"], name: "index_locations_on_area_id_and_location", using: :btree
  add_index "locations", ["city_id", "location"], name: "index_locations_on_city_id_and_location", using: :btree
  add_index "locations", ["location"], name: "index_locations_on_location", using: :btree

  create_table "members", force: :cascade do |t|
    t.string   "name",                limit: 255,                 null: false
    t.integer  "age",                 limit: 4
    t.boolean  "gender"
    t.boolean  "active",                          default: true,  null: false
    t.boolean  "aadhar_card",                     default: false, null: false
    t.boolean  "voter_card",                      default: false, null: false
    t.boolean  "bank_account",                    default: false, null: false
    t.boolean  "police_verification",             default: false, null: false
    t.datetime "enroll_date"
    t.datetime "renew_date"
    t.integer  "unnati_no",           limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description",         limit: 255
    t.boolean  "area_independent"
    t.boolean  "block",                           default: false
    t.datetime "last_activated"
    t.integer  "candidate_status_id", limit: 4
    t.integer  "english_profiency",   limit: 4
  end

  create_table "members_phones", id: false, force: :cascade do |t|
    t.integer "member_id", limit: 4, null: false
    t.integer "phone_id",  limit: 4, null: false
  end

  add_index "members_phones", ["member_id", "phone_id"], name: "index_members_phones_on_member_id_and_phone_id", using: :btree

  create_table "miss_call_numbers", force: :cascade do |t|
    t.string  "number",     limit: 255
    t.integer "partner_id", limit: 4
    t.boolean "active",                 default: true
  end

  create_table "partner_distributors", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", force: :cascade do |t|
    t.string   "name",                   limit: 255,                                         null: false
    t.string   "phone",                  limit: 255,                                         null: false
    t.string   "address",                limit: 255
    t.integer  "area_id",                limit: 4,                                           null: false
    t.integer  "total_phones_shared",    limit: 4,                            default: 0,    null: false
    t.integer  "total_new_phones",       limit: 4,                            default: 0,    null: false
    t.integer  "total_existing_phones",  limit: 4,                            default: 0,    null: false
    t.decimal  "total_credit_earned",                precision: 16, scale: 2, default: 0.0,  null: false
    t.decimal  "total_money_withdraw",               precision: 16, scale: 2, default: 0.0,  null: false
    t.decimal  "current_balance",                    precision: 16, scale: 2, default: 0.0,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255,                          default: ""
    t.string   "encrypted_password",     limit: 255,                          default: "",   null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,                            default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "shopname",               limit: 255
    t.boolean  "active",                                                      default: true
    t.string   "holder_name",            limit: 255
    t.string   "account_number",         limit: 255
    t.integer  "bank_id",                limit: 4
    t.string   "ifsc",                   limit: 255
    t.integer  "partner_distributor_id", limit: 4
  end

  add_index "partners", ["reset_password_token"], name: "index_partners_on_reset_password_token", unique: true, using: :btree

  create_table "partners_account_histories", force: :cascade do |t|
    t.integer  "partner_id",          limit: 4,                                        null: false
    t.integer  "phone_id",            limit: 4,                                        null: false
    t.boolean  "status"
    t.decimal  "credit",                        precision: 16, scale: 2, default: 0.0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "recharge_website_id", limit: 4
  end

  create_table "partners_account_summaries", force: :cascade do |t|
    t.integer "partner_id",            limit: 4,                                        null: false
    t.date    "date_of_transactions",                                                   null: false
    t.integer "total_phones_shared",   limit: 4,                          default: 0,   null: false
    t.integer "total_new_phones",      limit: 4,                          default: 0,   null: false
    t.integer "total_existing_phones", limit: 4,                          default: 0,   null: false
    t.decimal "credit",                          precision: 16, scale: 2, default: 0.0, null: false
    t.decimal "debit",                           precision: 16, scale: 2, default: 0.0, null: false
    t.decimal "balance",                         precision: 16, scale: 2, default: 0.0, null: false
  end

  create_table "payment_order_details", force: :cascade do |t|
    t.integer "payment_order_id", limit: 4
    t.integer "partner_id",       limit: 4
    t.decimal "amount",                     precision: 16, scale: 2, default: 0.0
    t.decimal "paid",                       precision: 16, scale: 2, default: 0.0
  end

  create_table "payment_orders", force: :cascade do |t|
    t.date     "from"
    t.date     "to"
    t.date     "payment_on"
    t.decimal  "amount",     precision: 16, scale: 2, default: 0.0
    t.decimal  "paid",       precision: 16, scale: 2, default: 0.0
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phones", force: :cascade do |t|
    t.string   "phone",                 limit: 255,             null: false
    t.integer  "area_id",               limit: 4
    t.boolean  "dnd"
    t.boolean  "whitelisted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "last_dnd_check_at"
    t.datetime "whitelisted_expiry_at"
    t.boolean  "welcome_call_sent"
    t.integer  "welcome_call_attempts", limit: 4,   default: 0
    t.boolean  "opt_out"
    t.boolean  "registered"
    t.boolean  "okay"
    t.boolean  "recharge_done"
  end

  create_table "recharge_websites", force: :cascade do |t|
    t.string "title", limit: 255, null: false
  end

  create_table "relations", force: :cascade do |t|
    t.integer "member_id",     limit: 4
    t.integer "phone_id",      limit: 4
    t.integer "relation_type", limit: 4
  end

  add_index "relations", ["member_id", "relation_type"], name: "index_relations_on_member_id_and_relation_type", using: :btree
  add_index "relations", ["member_id"], name: "index_relations_on_member_id", using: :btree
  add_index "relations", ["phone_id", "member_id"], name: "index_relations_on_phone_id_and_member_id", using: :btree

  create_table "salaries", force: :cascade do |t|
    t.integer "salary_type", limit: 4, null: false
    t.integer "salary",      limit: 4, null: false
    t.integer "member_id",   limit: 4
  end

  create_table "salary_grids", force: :cascade do |t|
    t.integer "category_id", limit: 4
    t.integer "min_salary",  limit: 4
    t.integer "max_salary",  limit: 4
  end

  create_table "test_caimpaign_statuses", force: :cascade do |t|
    t.string   "sid",               limit: 255
    t.string   "phone",             limit: 255
    t.string   "status",            limit: 255
    t.integer  "attempt_no",        limit: 4
    t.string   "sid_created_at",    limit: 255
    t.integer  "test_caimpaign_id", limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "test_caimpaigns", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "phone",          limit: 255,                 null: false
    t.string   "name",           limit: 255
    t.string   "email",          limit: 255
    t.string   "company_name",   limit: 255
    t.integer  "user_type",      limit: 4
    t.string   "address",        limit: 255
    t.boolean  "subscriber",                 default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "phone_valid",                default: false
    t.boolean  "email_valid",                default: false
    t.boolean  "phone_verified",             default: false
    t.boolean  "email_verified",             default: false
    t.boolean  "sms_alert",                  default: false
    t.boolean  "email_alert",                default: false
    t.string   "description",    limit: 255
    t.integer  "emp_type_id",    limit: 4
    t.integer  "industry_id",    limit: 4
  end

  add_index "users", ["emp_type_id"], name: "index_users_on_emp_type_id", using: :btree
  add_index "users", ["industry_id"], name: "index_users_on_industry_id", using: :btree
  add_index "users", ["phone"], name: "index_users_on_phone", using: :btree

  create_table "vnmappings", force: :cascade do |t|
    t.integer  "member_id",  limit: 4
    t.integer  "user_id",    limit: 4
    t.integer  "vnumber_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vnmappings", ["member_id"], name: "index_vnmappings_on_member_id", using: :btree
  add_index "vnmappings", ["user_id"], name: "index_vnmappings_on_user_id", using: :btree
  add_index "vnmappings", ["vnumber_id"], name: "index_vnmappings_on_vnumber_id", using: :btree

  create_table "vnumbers", force: :cascade do |t|
    t.string   "phone",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "welcome_calls", force: :cascade do |t|
    t.integer  "phone_id",      limit: 4,               null: false
    t.string   "recording_url", limit: 255
    t.string   "call_sid",      limit: 255,             null: false
    t.integer  "call_status",   limit: 4
    t.integer  "duration",      limit: 4,   default: 0, null: false
    t.integer  "member_id",     limit: 4
    t.integer  "status",        limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
