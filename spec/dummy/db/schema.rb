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

ActiveRecord::Schema.define(version: 2017_09_12_044257) do

  create_table "unity_subscription_plans", force: :cascade do |t|
    t.string "gateway_id"
    t.string "period"
    t.string "price"
    t.string "group_enrollment_add_on_price"
    t.string "name", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "unity_subscriptions", force: :cascade do |t|
    t.integer "user_id"
    t.integer "subscription_plan_id"
    t.string "gateway_id"
    t.integer "gateway_status"
    t.integer "gateway_type"
    t.datetime "trial_ends_at"
    t.boolean "group_enrolled"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_plan_id"], name: "index_unity_subscriptions_on_subscription_plan_id"
    t.index ["user_id"], name: "index_unity_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
