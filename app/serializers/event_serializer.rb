class EventSerializer < ActiveModel::Serializer
  attributes \
    :id,
    :name,
    :date

  # link(:self) { v1_event_url(object) }
end
