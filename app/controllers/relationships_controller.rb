class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  def create
    follow = current_user.relationships.build(follower_id: params[:user_id])
    follow.save
    redirect_to request.referrer || root_path
  end

  def destroy
    follow = current_user.relationships.find_by(follower_id: params[:user_id])
    follow.destroy
    redirect_to request.referrer || root_path
  end

end
