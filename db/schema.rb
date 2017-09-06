ActiveRecord::Schema.define(version: 20170905194143) do

  create_table "friendships", force: :cascade do |t|
    t.integer  "friend_one_id"
    t.integer  "friend_two_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["friend_one_id", "friend_two_id"], name: "index_friendships_on_friend_one_id_and_friend_two_id", unique: true
  end

  create_table "puppies", force: :cascade do |t|
    t.string   "name",                       null: false
    t.integer  "stomach",    default: 10,    null: false
    t.integer  "bladder",    default: 0,     null: false
    t.integer  "bowel",      default: 0,     null: false
    t.boolean  "bored",      default: false, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_puppies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
