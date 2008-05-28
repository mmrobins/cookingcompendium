class RatingController < ApplicationController

  def rate
    @asset = Recipe.find(params[:id])
    Rating.delete_all(["rateable_type = 'Recipe' AND rateable_id = ? AND user_id = ?", 
      @asset.id, current_user.id])
    @asset.add_rating Rating.new(:rating => params[:rating], 
      :user_id => current_user.id)
  end

end