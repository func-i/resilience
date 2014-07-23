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

ActiveRecord::Schema.define(version: 20140723160803) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachments", force: true do |t|
    t.string   "title"
    t.string   "file_name"
    t.string   "file_uid"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree
  add_index "attachments", ["file_uid"], name: "index_attachments_on_file_uid", using: :btree

  create_table "building_blocks", force: true do |t|
    t.string   "title"
    t.integer  "owner_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "building_blocks", ["owner_id"], name: "index_building_blocks_on_owner_id", using: :btree

  create_table "registration_invitations", force: true do |t|
    t.integer  "sender_id"
    t.string   "recipient_email"
    t.integer  "recipient_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
  end

  add_index "registration_invitations", ["invitation_token"], name: "index_registration_invitations_on_invitation_token", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "title"
    t.string   "organization"
    t.string   "phone"
    t.string   "website"
    t.string   "photo_name"
    t.string   "photo_uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["photo_uid"], name: "index_users_on_photo_uid", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
