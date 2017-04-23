class ImportService
  class << self
    def import_playlist(artist_name:, event_date:)
      @artist_name = artist_name
      @event_date = event_date

      query_setlist
      persist_event
      query_playlist
      persist_playlist
      # rescue ImportService::Error => error
      #   # There was an error
      #   { errors: 'There was an error. Check the log for specifics.' }
    end

    private

    def query_setlist
      @setlist = Setlistfm::QueryService
        .setlist(
          artist_name: @artist_name,
          event_date: @event_date
        )
    end

    def persist_event
      Event.find_or_create_by(
        @setlist[:event].merge(date: @event_date)
      )
    end

    def query_playlist
      Spotify::QueryService
        .playlist(@artist_name)
    end

    def persist_playlist
    end
  end
end
