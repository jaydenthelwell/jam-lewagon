class TopGenresController < ApplicationController

  def new
    @top_genre = TopGenre.new
  end

  def create
    params[:top_genre][:genre].each do |genre|
      if genre.present?
        @top_genre = TopGenre.new(genre: genre)
        @top_genre.user = current_user
        @top_genre.save!
      end
    end

    redirect_to root_path

  end
end
