class LikesController < ApplicationController
  def create
    @like = Like.new(post_id: params[:post_id])
    @like.user = current_user
    @like.save
    redirect_to root_path
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to root_path
  end
end
