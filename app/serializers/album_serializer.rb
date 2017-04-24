class AlbumSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :spotify_identifier,
    :name,
    :release_date,
    :release_date_precision

  # link(:self) { v1_event_url(object) }
end
