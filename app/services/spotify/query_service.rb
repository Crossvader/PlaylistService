module Spotify
  class QueryService
    class << self
      BASE_URI = 'https://api.spotify.com/v1'
      ENDPOINTS = {
        search: "#{BASE_URI}/search",
        albums: "#{BASE_URI}/albums"
      }

      def playlist(artist_name:, track_names:, playlist:)
        @artist_name = artist_name
        @track_names = track_names
        @playlist = playlist

        query_tracks
        @playlist
      end

      private

      def query_tracks
        hydra = Typhoeus::Hydra.new

        @track_names.each_with_index do |track_name, index|
          request = new_request(track_name)

          request.on_complete do |response|
            parse_track(response, index)
          end

          hydra.queue(request)
        end

        hydra.run
      end

      def new_request(track_name)
        Typhoeus::Request.new(
          ENDPOINTS[:search],
          params: {
            q: "#{track_name} #{@artist_name}",
            type: 'track,artist',
            limit: 1
          }
        )
      end

      def parse_track(response, index)
        parsed_track = Spotify::SearchTrackParser
          .parse(response.response_body)
          .merge(position: index)

        album_response = query_album(parsed_track[:spotify_album_identifier])

        parsed_track
          .merge!(album: parsed_album(album_response))
          .except!(:spotify_album_identifier)

        persist_playlist_track(parsed_track)
      end

      def query_album(spotify_album_identifier)
        Typhoeus.get("#{ENDPOINTS[:albums]}/#{spotify_album_identifier}")
      end

      def parsed_album(album_response)
        Spotify::AlbumParser
          .parse(album_response.response_body)
      end

      # TODO: This shouldn't be the responsibility of this service. Move to
      # background job, data pipeline, etc.
      def persist_playlist_track(parsed_track)
        position = parsed_track.extract!(:position).values.first

        album = Album.find_or_initialize_by(
          parsed_track.slice(:album)[:album]
        )

        artist = Artist.find_or_initialize_by(
          parsed_track.slice(:artist)[:artist]
        )

        track = Track.find_or_initialize_by(
          parsed_track.except(:album, :artist)
          .merge(album: album)
          .merge(artist: artist)
        )

        PlaylistTrack.find_or_create_by(
          playlist: @playlist,
          track: track,
          position: position
        )
      end
    end
  end
end
