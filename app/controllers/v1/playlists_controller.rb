module V1
  class PlaylistsController < ApplicationController
    def search
      playlist = ImportService.import_playlist(
        artist_name: params[:artist_name],
        event_date: params[:event_date]
      )

      render json: playlist
    end
  end
end
