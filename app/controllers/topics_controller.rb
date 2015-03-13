class TopicsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def index
    @topics = Topic.all
  end

  def show
    @topic = Topic.find(params[:id])
    @bookmarks = @topic.bookmarks
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(params.require(:topic).permit(:title, :body))
    if @topic.save
      flash[:notice] = "Topic saved."
      redirect_to @topic
    else
      flash[:error] = "Error creating topic. Try again."
      render :new
    end
  end

  def edit
  end
end
