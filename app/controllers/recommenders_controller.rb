class RecommendersController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_recommender, only: [:new, :create]

  def promise
  end

  def new
    @recommender = Recommender.new
  end

  def create
    @recommender = Recommender.new(recommender_params)
    user = current_user
    @recommender.user = user
    user.update_attribute(:isRecommender, true)
    if @recommender.save
      flash[:notice] = "リコメンダになりました"
      redirect_to user_path(current_user)
    else
      render 'users/show'
    end
  end

  private
  def recommender_params
    params.require(:recommender).permit(:real_name, :phone_number, :address)
  end

  def baria_recommender
    unless current_user.isRecommender.present?
      user_path(current_user)
    end
  end
end
