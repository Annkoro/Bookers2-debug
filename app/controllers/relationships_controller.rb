class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  # def create
  #   follow = current_user.relationships.build(follower_id: params[:user_id])
  #   follow.save
  #   redirect_to request.referrer || root_path
  # end

  # def destroy
  #   follow = current_user.relationships.find_by(follower_id: params[:user_id])
  #   follow.destroy
  #   redirect_to request.referrer || root_path
  # end

  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
		redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
		redirect_to request.referer
  end

  def followings
    user = User.find(params[:user_id])
		@users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
		@users = user.followers
  end

end
