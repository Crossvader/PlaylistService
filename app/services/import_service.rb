class ImportService
  class << self
    def import_playlist(artist_name:, event_date:)
      @artist_name = artist_name
      @event_date = event_date

      query_setlist
      query_playlist
      save_playlist
      # rescue ImportService::Error => error
      #   # There was an error
      #   { errors: 'There was an error. Check the log for specifics.' }
    end

    private

    def query_setlist
      Setlistfm::QueryService
        .get_setlist(
          artist_name: @artist_name,
          event_date: @event_date
        )
    end

    def query_playlist
      Spotify::QueryService
        .get_playlist(@artist_name)
    end

    def save_playlist
    end
  end
end
