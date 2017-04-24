module V1
  class PlaylistsController < ApplicationController
    # ImportService.import_playlist(artist_name: 'Chromeo', event_date: '2017-02-18')
    def search
      playlist = ImportService.import_playlist(
        artist_name: params[:artist_name],
        event_date: params[:event_date]
      )

      render json: playlist
    end
  end
end
