class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @pending_friends = Friendship.pending(current_user.id)
    @accepted_friends = Friendship.accepted(current_user.id)
  end

  def show
    @user = User.find(params[:id])
    @profile = @user.profile
    @posts = @user.posts
    @pending_friends = Friendship.pending(current_user.id)
    @accepted_friends = Friendship.accepted(current_user.id)
  end
end
