module Spotify
  class AlbumParser
    class << self
      def parse(response_body)
        @parsed_response = JSON.parse(response_body)

        {
          spotify_identifier: spotify_identifier,
          name: name,
          release_date: release_date,
          release_date_precision: release_date_precision
        }
      end

      private

      def spotify_identifier
        @parsed_response
          .try(:[], 'id')
      end

      def name
        @parsed_response
          .try(:[], 'name')
      end

      def release_date
        @parsed_response
          .try(:[], 'release_date')
      end

      def release_date_precision
        @parsed_response
          .try(:[], 'release_date_precision')
      end
    end
  end
end
