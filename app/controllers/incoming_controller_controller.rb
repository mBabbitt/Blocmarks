class IncomingControllerController < ApplicationController
   # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    # You put the message-splitting and business
    # magic here.
     # Find the user by using params[:sender]
     @user = User.find_by_email(params[:sender])
     # Find the topic by using params[:subject]
     @topic = Topic.find_by_title(params[:subject])
     # Assign the url to a variable after retreiving it from params["body-plain"]
     @url = params["body-plain"]
     # Check if user is nil, if so, create and save a new user
    if @user.nil?
      @user = User.new(
        first_name:            params[:sender],
        last_name:             params[:sender],
        email:                 params[:sender],
        password:              params[:sender],
        password_confirmation: params[:sender]
      )
      @user.save
    end
     # Check if the topic is nil, if so, create and save a new topic
    if @topic.nil?
      @topic = @user.topics.build(
        title: params[:subject]
      )
      @topic.save
    end
     # Now that you're sure you have a valid user and topic, build and save a new bookmark
    @bookmark = @topic.bookmarks.build(url: @url)
    @bookmark.save
    # Assuming all went well.
    head 200
  end
end