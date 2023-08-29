class MatchesController < ApplicationController
  def create
    @match = Match.new(matches_params)
    if @match.save
      redirect_to root_path, notice: "match was successfully created."
    else
      render :matches, status: :unprocessable_entity
    end
  end


  private

  def matches_params
    params.require(:match).permit(:swipe_id)
  end

end
