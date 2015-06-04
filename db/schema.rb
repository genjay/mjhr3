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

ActiveRecord::Schema.define(version: 20150604040923) do

  create_table "annual_leave_lists", force: :cascade do |t|
    t.integer  "months_of_job", limit: 4
    t.integer  "days",          limit: 4
    t.text     "memo",          limit: 65535
    t.integer  "ou_id",         limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "catcodes", force: :cascade do |t|
    t.string   "m_name",     limit: 255
    t.string   "col_name",   limit: 255
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.boolean  "is_stoped",  limit: 1
    t.integer  "ou_id",      limit: 4
    t.text     "memo",       limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "departments", force: :cascade do |t|
    t.string   "uid",         limit: 255
    t.string   "name",        limit: 255
    t.integer  "worktype_id", limit: 4
    t.integer  "upper_id",    limit: 4
    t.boolean  "is_stoped",   limit: 1
    t.text     "memo",        limit: 65535
    t.integer  "ou_id",       limit: 4
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "departments", ["worktype_id"], name: "index_departments_on_worktype_id", using: :btree

  create_table "insurance_settings", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.boolean  "is_stoped",  limit: 1
    t.text     "memo",       limit: 65535
    t.integer  "ou_id",      limit: 4
    t.decimal  "a_rate",                   precision: 10
    t.decimal  "a_employee",               precision: 10
    t.decimal  "a_compayny",               precision: 10
    t.decimal  "b_rate",                   precision: 10
    t.decimal  "b_employee",               precision: 10
    t.decimal  "b_compayny",               precision: 10
    t.decimal  "c_rate",                   precision: 10
    t.decimal  "c_employee",               precision: 10
    t.decimal  "c_compayny",               precision: 10
    t.decimal  "d_rate",                   precision: 10
    t.decimal  "d_employee",               precision: 10
    t.decimal  "d_compayny",               precision: 10
    t.decimal  "e_rate",                   precision: 10
    t.decimal  "e_employee",               precision: 10
    t.decimal  "e_compayny",               precision: 10
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "offtypes", force: :cascade do |t|
    t.string   "uid",             limit: 255
    t.string   "name",            limit: 255
    t.integer  "mins_of_minimum", limit: 4
    t.integer  "mins_per_unit",   limit: 4
    t.integer  "deduct_percent",  limit: 4
    t.boolean  "include_holiday", limit: 1
    t.boolean  "can_duplicate",   limit: 1
    t.boolean  "is_quota_ctrl",   limit: 1
    t.boolean  "is_stoped",       limit: 1
    t.text     "memo",            limit: 65535
    t.integer  "ou_id",           limit: 4
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "ous", force: :cascade do |t|
    t.string   "uid",                        limit: 255
    t.string   "name",                       limit: 255
    t.integer  "overwork_hours_for_freetax", limit: 4
    t.integer  "days_per_month",             limit: 4
    t.integer  "hours_per_day",              limit: 4
    t.decimal  "LP_rate",                                  precision: 10
    t.decimal  "welfare_rate",                             precision: 10
    t.text     "memo",                       limit: 65535
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
  end

  create_table "overtypes", force: :cascade do |t|
    t.string   "uid",           limit: 255
    t.string   "name",          limit: 255
    t.integer  "mins_of_A",     limit: 4
    t.integer  "mins_of_B",     limit: 4
    t.decimal  "rate_of_A",                   precision: 10
    t.decimal  "amt_of_A",                    precision: 10
    t.decimal  "rate_of_B",                   precision: 10
    t.decimal  "amt_of_B",                    precision: 10
    t.decimal  "rate_of_C",                   precision: 10
    t.decimal  "amt_of_C",                    precision: 10
    t.decimal  "rate_of_H",                   precision: 10
    t.decimal  "amt_of_H",                    precision: 10
    t.integer  "mins_per_unit", limit: 4
    t.string   "valid_unit",    limit: 255
    t.boolean  "is_stoped",     limit: 1
    t.string   "pay_type",      limit: 255
    t.text     "memo",          limit: 65535
    t.integer  "ou_id",         limit: 4
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "pay_types", force: :cascade do |t|
    t.string   "uid",            limit: 255
    t.string   "name",           limit: 255
    t.string   "cycle_unit",     limit: 255
    t.string   "rule_for_break", limit: 255
    t.boolean  "is_stoped",      limit: 1
    t.integer  "ou_id",          limit: 4
    t.text     "memo",           limit: 65535
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "subsidies", force: :cascade do |t|
    t.string   "uid",        limit: 255
    t.string   "name",       limit: 255
    t.decimal  "rate",                     precision: 10
    t.text     "memo",       limit: 65535
    t.boolean  "is_stoped",  limit: 1
    t.integer  "ou_id",      limit: 4
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  create_table "workrests", force: :cascade do |t|
    t.integer  "worktype_id",        limit: 4
    t.boolean  "is_holiday",         limit: 1
    t.time     "rest_begin_at"
    t.integer  "mins_of_rest",       limit: 4
    t.boolean  "is_deduct_for_duty", limit: 1
    t.text     "memo",               limit: 65535
    t.integer  "ou_id",              limit: 4
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "workrests", ["worktype_id"], name: "index_workrests_on_worktype_id", using: :btree

  create_table "worktypes", force: :cascade do |t|
    t.string   "uid",                      limit: 255
    t.string   "name",                     limit: 255
    t.time     "on_duty_at"
    t.time     "off_duty_at"
    t.integer  "buffer_before_duty",       limit: 4
    t.integer  "buffer_after_duty",        limit: 4
    t.integer  "minimum_before_overwork",  limit: 4
    t.integer  "minimum_after_overwork",   limit: 4
    t.integer  "minimum_holiday_overwork", limit: 4
    t.integer  "range_on",                 limit: 4
    t.integer  "range_off",                limit: 4
    t.boolean  "is_stoped",                limit: 1
    t.integer  "mins_of_duty",             limit: 4
    t.text     "memo",                     limit: 65535
    t.integer  "ou_id",                    limit: 4
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_foreign_key "departments", "worktypes"
  add_foreign_key "workrests", "worktypes"
end
