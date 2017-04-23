module Setlistfm
  class QueryService
    class << self
      BASE_URI = 'https://api.setlist.fm/rest/0.1'
      ENDPOINTS = {
        search_setlists: "#{BASE_URI}/search/setlists.json"
      }

      def get_setlist(artist_name:, event_date:)
        @artist_name = artist_name
        @event_date = event_date

        query_setlist
        parse_setlist
      end

      private

      def query_setlist
        @response = Typhoeus
          .get(
            ENDPOINTS[:search_setlists],
            params: {
              'artistName': @artist_name,
              date: reformatted_date
            }
          )
      end

      def parse_setlist
        Setlistfm::SetlistParser
          .song_names(@response.response_body)
      end

      def reformatted_date
        @event_date.to_date.strftime('%d-%m-%Y')
      end
    end
  end
end
