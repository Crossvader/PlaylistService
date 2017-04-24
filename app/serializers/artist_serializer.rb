class ArtistSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :name

  # link(:self) { v1_event_url(object) }
end
