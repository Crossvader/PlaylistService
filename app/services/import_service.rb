class ImportService
  class << self
    def import_playlist(artist_name:, event_date:)
      @artist_name = artist_name
      @event_date = event_date

      query_setlist
      persist_event
      persist_playlist
      query_playlist
    rescue StandardError
      # TODO: Add comprehensive error handling
      # * Don't rescue StandardError
      # * Create our own custom errors and bubble those up
      {}
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
      @event = Event.find_or_create_by(
        @setlist[:event].merge(date: @event_date)
      )
    end

    def query_playlist
      @playlist = Spotify::QueryService
        .playlist(
          artist_name: @artist_name,
          track_names: @setlist[:track_names],
          playlist: @playlist
        )
    end

    def persist_playlist
      playlist_name = "#{@artist_name} #{@event_date}"

      @playlist = Playlist.find_or_create_by(
        event: @event,
        name: playlist_name
      )
    end
  end
end
