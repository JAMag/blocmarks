class IncomingController < ApplicationController

  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    
     user = User.find_by_email(params[:sender])
      if user
        topic = Topic.find_or_create_by(params[:subject])
        #bookmark = Bookmark.find_or_create_by(url: params["body-plain"])
        bookmark = user.bookmarks.find_or_build_by(url: params["body-plain"])
        bookmark.topic = topic
        bookmark.save
        #user_bookmark = UserBookmark.create(user: user, bookmark: bookmark)
        
        #topic_bookmark = TopicBookmark.create(topic: topic, bookmark: bookmark)
      end
    
    head 200
  end
end