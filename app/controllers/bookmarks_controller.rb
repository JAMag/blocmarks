class BookmarksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def show
    @bookmark = Bookmark.find(params [:id])
  end

  def index
    @bookmarks = Bookmark.all
    @topics = Topic.all
  end

  def new
    @bookmark = Bookmark.new(params.require(:bookmark).permit(:title, :body))
    authorize @bookmark
    if @bookmark.save
      flash[:notice] = "Bookmark saved."
      redirect_to @bookmark
    else
      flash[:error] = "Error creating bookmark. Try again."
      render :new
    end
  end

  def edit
  end

  def update
    @bookmark = Bookmark.find(params [:id])
    if @bookmark.update_attributes(params[:bookmark])
      redirect_to @bookmark, notice: "Successfully updated bookmark."
    else
      render :edit
    end
  end

  def create
      @topic = Topic.find_or_create_by(title: params[:bookmark][:topic])
      @bookmark = Bookmark.new(bookmark_params)
      @bookmark.topic = @topic
      @bookmark.user = current_user
      if @bookmark.save
        redirect_to bookmarks_path 
        flash[:notice] = "Bookmark created!"
      else
        flash[:error] = "There was an error saving the bookmark. Please try again."
        render :new
      end
  end

  def destroy 
    @bookmark = Bookmark.find(params [:id])
    @bookmark.destroy
    redirect_to bookmarks_url, notice: "You destroyed your bookmark. I hope you wanted to."
  end
end
