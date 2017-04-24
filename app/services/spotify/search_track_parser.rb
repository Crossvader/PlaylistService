module Spotify
  class SearchTrackParser
    class << self
      def parse(response_body)
        @parsed_response = JSON.parse(response_body)
          .try(:[], 'tracks')
          .try(:[], 'items')
          .first

        {
          spotify_album_identifier: spotify_album_identifier,
          spotify_identifier: spotify_identifier,
          name: name,
          isrc: isrc,
          duration: duration,
          artist: {
            spotify_identifier: artist_spotify_identifer,
            name: artist_name
          }
        }
      end

      private

      def spotify_album_identifier
        @parsed_response
          .try(:[], 'album')
          .try(:[], 'id')
      end

      def spotify_identifier
        @parsed_response
          .try(:[], 'id')
      end

      def name
        @parsed_response
          .try(:[], 'name')
      end

      def isrc
        @parsed_response
          .try(:[], 'external_ids')
          .try(:[], 'isrc')
      end

      def duration
        @parsed_response
          .try(:[], 'duration_ms')
      end

      def artist_spotify_identifer
        @parsed_response
          .try(:[], 'artists')
          .try(:first)
          .try(:[], 'id')
      end

      def artist_name
        @parsed_response
          .try(:[], 'artists')
          .try(:first)
          .try(:[], 'name')
      end
    end
  end
end
