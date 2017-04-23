module Setlistfm
  class SetlistParser
    class << self
      def parse(response_body)
        @parsed_response = JSON.parse(response_body)
          .try(:[], 'setlists')
          .try(:[], 'setlist')

        {
          event: {
            setlistfm_identifer: event_id,
            name: event_name
          },
          song_names: song_names
        }
      end

      private

      def event_id
        @parsed_response
          .try(:[], 'venue')
          .try(:[], '@id')
      end

      def event_name
        @parsed_response
          .try(:[], 'venue')
          .try(:[], '@name')
      end

      def song_names
        @parsed_response
          .try(:[], 'sets')
          .try(:[], 'set')
          .try(:[], 'song')
          .try(:map) { |key, _value| key.first[1] }
      end
    end
  end
end
