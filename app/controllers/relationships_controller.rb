class RelationshipsController < ApplicationController

  def create
    @user = User.find(params[:relationship][:following_id])
    @current_user_follow!(@user)
    redirect_to @user
  end

  def destroy
    @user = Relationship.find(params[:id]).following
    @current_user_unfollow!(@user)
    redirect_to @user
  end
end
