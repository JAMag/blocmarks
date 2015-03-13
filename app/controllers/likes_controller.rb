class LikesController < ApplicationController

  def create
    logger.info "PARAM #{params[:bookmark_id]}"
    @bookmark = Bookmark.find(params[:bookmark_id])
    logger.info "BOOKMARK #{@bookmark.inspect}"
    like = current_user.likes.build(bookmark: @bookmark)
    logger.info "LIKE #{like.inspect}"
    if like.save
      redirect_to :back, notice: "You like something!"
    else
      redirect_to :back, notice: "Something's amiss! Please try again."
    end
  end

  def destroy
    @like = Like.find(params[:id])

    if @like.destroy
      redirect_to :back, notice: "You no longer like that."
    else
      redirect_to :back, notice: "Something is terribly wrong! Please try again."
    end
  end
end
