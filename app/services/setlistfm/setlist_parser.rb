module Setlistfm
  class SetlistParser
    def self.song_names(response_body)
      JSON
        .parse(response_body)
        .try(:[], 'setlists')
        .try(:[], 'setlist')
        .try(:[], 'sets')
        .try(:[], 'set')
        .try(:[], 'song')
        .try(:map) { |key, _value| key.first[1] }
    end
  end
end
