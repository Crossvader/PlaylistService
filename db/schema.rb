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

ActiveRecord::Schema.define(version: 20170423174737) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "albums", force: :cascade do |t|
    t.string   "spotify_identifier"
    t.string   "name"
    t.string   "release_date"
    t.string   "release_date_precision"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string   "spotify_identifier"
    t.string   "name"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "playlist_tracks", force: :cascade do |t|
    t.integer  "playlist_id"
    t.integer  "track_id"
    t.integer  "position"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["playlist_id"], name: "index_playlist_tracks_on_playlist_id", using: :btree
    t.index ["track_id"], name: "index_playlist_tracks_on_track_id", using: :btree
  end

  create_table "playlists", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_playlists_on_event_id", using: :btree
  end

  create_table "tracks", force: :cascade do |t|
    t.integer  "artist_id"
    t.integer  "album_id"
    t.string   "spotify_identifier"
    t.string   "name"
    t.string   "isrc"
    t.integer  "duration"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["album_id"], name: "index_tracks_on_album_id", using: :btree
    t.index ["artist_id"], name: "index_tracks_on_artist_id", using: :btree
  end

  add_foreign_key "playlist_tracks", "playlists"
  add_foreign_key "playlist_tracks", "tracks"
  add_foreign_key "playlists", "events"
  add_foreign_key "tracks", "albums"
  add_foreign_key "tracks", "artists"
end
