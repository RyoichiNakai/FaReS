class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:show, :edit, :update]
  before_action :set_user, only: [:show, :profile, :edit, :update]

  def show
    @topic = Topic.new
    @topics = Topic.where(user_id: current_user.id)
  end

  def profile
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image, :gender,
                                 :age, :height, :weight, :west, :hip, :chest, :introduction, :isRecommender)
  end

  def baria_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      flash[:alert] = "ページ遷移できません"
      redirect_to user_path(current_user)
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
