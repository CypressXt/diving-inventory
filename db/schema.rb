# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_30_160903) do

  create_table "pressurelogs", force: :cascade do |t|
    t.integer "tank_id"
    t.integer "pressure_start"
    t.integer "pressure_end"
    t.integer "o2_percentage"
    t.datetime "filling_timestamp"
    t.datetime "emptying_timestamp"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tank_id"], name: "index_pressurelogs_on_tank_id"
  end

  create_table "tanks", force: :cascade do |t|
    t.integer "tank_number"
    t.integer "volume"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["tank_number"], name: "index_tanks_on_tank_number", unique: true
  end

end
