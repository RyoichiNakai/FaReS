class TopicsController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_topic, only: [:show, :delete]
  before_action :baria_topic, only: [:show, :new, :create]
  def index
    @topics = Topic.all
  end

  def show
    @recommends = Recommend.all
  end

  def new
    @topic = Topic.new
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topic_path(@topic)
    else
      render :new
    end
  end

  def delete
    @topic.destroy
    redirect_to user_path(current_user)
  end

  private
  def topic_params
    params.require(:topic).permit(:image, :text)
  end

  def baria_topic
    topic = Topic.find(params[:id])
    unless topic.user.id != current_user.id
      redirect_back fallback_location: request.url
    end
  end

  def set_topic
    @topic = Topic.find(params[:id])
  end

end