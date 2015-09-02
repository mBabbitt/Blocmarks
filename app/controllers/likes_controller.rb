class LikesController < ApplicationController
  def create
    bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: bookmark)
    authorize like
    if like.save
      flash[:notice] = "Bookmark has been liked successfully."
      redirect_to [bookmark.topic, bookmark]
    else
      flash[:error] = "There was an error liking the bookmark. Please try again."
      redirect_to [bookmark.topic, bookmark]
    end
  end

  def destroy
    bookmark = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.find(params[:id])
    authorize like
    if like.destroy
      flash[:notice] = "Bookmark has been unliked successfully."
      redirect_to [bookmark.topic, bookmark]
    else
      flash[:error] = "There was an error unliking the bookmark. Please try again."
      redirect_to [bookmark.topic, bookmark]
    end
  end
end