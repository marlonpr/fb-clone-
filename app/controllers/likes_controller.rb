class LikesController < ApplicationController
  def create
    @like = Like.new(like_params)
    @like.user = current_user
    @like.save
    redirect_to :back
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to :back
  end

  private

  def like_params
    params.require(:like).permit(:post_id)
  end
end

