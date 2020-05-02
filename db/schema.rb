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

ActiveRecord::Schema.define(version: 2020_05_02_172742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "hamburguesa_ingredientes", force: :cascade do |t|
    t.integer "hamburguesa_id"
    t.integer "ingrediente_id"
  end

  create_table "hamburguesas", force: :cascade do |t|
    t.string "nombre"
    t.integer "precio"
    t.string "descripcion"
    t.string "imagen"
    t.jsonb "ingredientes", default: []
  end

  create_table "ingredientes", force: :cascade do |t|
    t.string "nombre"
    t.string "descripcion"
  end

end
