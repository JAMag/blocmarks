class LikesController < ApplicationController

  def create
    @bookmarks = Bookmark.find(params[:bookmark_id])
    like = current_user.likes.build(bookmark: @bookmark)

    if @like.save
      redirect_to bookmarks_path, notice: "You like something!"
    else
      redirect_to bookmarks_path, notice: "Something's amiss. Please try again."
    end
  end

  def destroy
    @like = Like.find( params[:id])

    if @like.destroy
      redirect_to bookmarks_path, notice: "You no longer like that."
    else
      redirect_to bookmarks_path, notice: "Something is terribly wrong. Please try again."
    end
  end
end
