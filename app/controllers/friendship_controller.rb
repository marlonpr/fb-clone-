class FriendshipController < ApplicationController
  before_action :authenticate_user!

  def send_friend_request
    @friendship = Friendship.new(sender: current_user, receiver_id: params[:receiver_id], status: :pending)
    if @friendship.save
      flash[:notice] = "Friend request sent"
    else
      flash[:alert] = "Could not send friend request"
    end
    redirect_to root_path
  end

  def handle_friend_request
    @friendship = Friendship.find(params[:id])
    if @friendship.update(status: params[:status])
      flash[:notice] = "Friend request #{params[:status]}"
    else
      flash[:alert] = "Could not handle friend request"
    end
    redirect_to root_path
  end

  def index
    @pending_friends = current_user.pending_friends
  end

  def friends
    @friends = current_user.friends
  end

  def remove_friend
    friendship = Friendship.find_by(sender_id: current_user.id, receiver_id: params[:id]) || Friendship.find_by(sender_id: params[:id], receiver_id: current_user.id)
    friendship.destroy
    flash[:notice] = "Friend removed"
    redirect_to friends_path
  end
end
