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

ActiveRecord::Schema.define(version: 2018_07_10_122736) do

  create_table "package_build_logs", force: :cascade do |t|
    t.integer "package_id"
    t.string "pkgver"
    t.datetime "latest_build_time"
    t.boolean "building_ok"
    t.integer "building_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_package_build_logs_on_package_id"
  end

  create_table "packages", force: :cascade do |t|
    t.string "pkgname"
    t.string "pkgver"
    t.datetime "latest_build_time"
    t.boolean "building_ok"
    t.integer "building_time"
    t.integer "successful_counts", default: 0, null: false
    t.integer "failed_counts", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
