class PlaylistSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :name

  has_one :event
  has_many :tracks

  # link(:self) { v1_event_url(object) }
end
