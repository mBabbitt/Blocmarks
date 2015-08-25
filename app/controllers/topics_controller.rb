class TopicsController < ApplicationController
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

  def edit
    @topic = Topic.find(params[:id])
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to @topic, notice: "Topic was saved"
    else
      flash[:error] = "Error creating topic."
      render :new
    end
  end

  def update
     @topic = Topic.find(params[:id])
     if @topic.update_attributes(topic_params)
       redirect_to @topic, notice: "Topic was updated"
     else
       flash[:error] = "Error saving topic. Please try again."
       render :edit
     end
  end

  def destroy
    @topic = Topic.find(params[:id])
    if @topic.destroy
      flash[:notice] = "Topic was deleted successfully"
      redirect_to topics_path
    else
      flash[:error] = "There was an error deleting the topic"
      render :show
    end
  end

private

  def topic_params
    params.require(:topic).permit(:title)
  end
end