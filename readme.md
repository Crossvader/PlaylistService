# Playlist Service

[![Code Climate](https://codeclimate.com/github/Crossvader/playlist/badges/gpa.svg)](https://codeclimate.com/github/Crossvader/playlist)

## Reference

 * [REST API documentation](http://docs.crossvader.apiary.io/)
 * [Code Quality](https://codeclimate.com/github/Crossvader/playlist)

## Process

 * Create API endpoint that takes artist_name and event_date params
 * Retrieve setlist from setlist.fm
   - Convert event_date to dd-mm-yyyy
   - Memoize/Cache request/response
     - https://api.setlist.fm/rest/0.1/search/setlists.json?artistName=Chromeo&date=18-02-2017
   - Parse response for Event(date, venue_name) and Tracks(name)
     - tracks = JSON.parse(resp.response_body)['setlists']['setlist']['sets']['song'].map{ |key, value| key.first[1] }
 * Return {} if setlist has no data or if parsing fails
 * Store Event(date, venue_name) in database
 * Asynchronously request track and album details for each track
   - Find track by name
     - Memoize/Cache request/response
     - https://api.spotify.com/v1/search?q=night+by+night+chromeo&type=track,artist&limit=1
   - Parse response
   - Store Track(album_id, spotify_identifier, name, isrc, duration)
   - Find album by spotify_identifier
     - Memoize/Cache request/response
     - https://api.spotify.com/v1/albums/7iZU6KMPD0iT7QqtMkTmL1
     - Store Album(spotify_identifier, name, release_date, release_date_precision)
  * Return Playlist with Track, Album, and Event data as JSON

## Models

 * Playlist
   - has_many :tracks, through: :playlist_tracks, -> { order: { position: :desc } }
   - belongs_to :event
   - event_id
   - name
 * PlaylistTrack
   - belongs_to :playlist
   - belongs_to :track
   - playlist_id
   - track_id
   - position
 * Track
   - has_many :playlists, through: :playlist_tracks
   - belongs_to :artist
   - belongs_to :album
   - artist_id
   - album_id
   - spotify_identifier
   - name
   - isrc
   - duration
 * Artist
   - has_many :tracks
   - spotify_identifier
   - name
 * Album
   - has_many :tracks
   - spotify_identifier
   - name
   - release_date
   - release_date_precision
 * Event
   - has_many :playlists
   - name
   - date
