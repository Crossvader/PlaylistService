class TrackSerializer < ActiveModel::Serializer
  attributes \
    :spotify_identifier,
    :name,
    :isrc,
    :duration,
    :album_release_date,
    :album_release_date_precision

  def album_release_date
    object.album.release_date
  end

  def album_release_date_precision
    object.album.release_date_precision
  end

  # link(:self) { v1_event_url(object) }
end
