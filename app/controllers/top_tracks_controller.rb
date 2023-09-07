class TopTracksController < ApplicationController
  def new
    # @authorized = true if params['code']
    @top_track = TopTrack.new
  end

  def spotify
    @top_track = TopTrack.new
  end

  def create
    @top_track = TopTrack.new(track: params[:top_track][:track], spotify_ref: params[:top_track][:spotify_ref])
    @top_track.user = current_user
    @top_track.save!
  end

  def destroy_all
    current_user.top_tracks.each do |track|
      track.delete
    end
  end


end
