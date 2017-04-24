class Playlist < ApplicationRecord
  has_many :playlist_tracks
  has_many :tracks,
    -> { order 'playlist_tracks.position desc' },
    through: :playlist_tracks
  belongs_to :event
end
