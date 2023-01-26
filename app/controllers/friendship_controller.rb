class FriendshipController < ApplicationController
  before_action :authenticate_user!

  def index
    @pending_friends = Friendship.pending(current_user.id)
  end

  def send_friend_request
    @friendship = Friendship.new(sender: current_user, receiver_id: params[:receiver_id], status: :pending)
    if @friendship.save
      flash[:notice] = "Friend request sent"
    else
      flash[:alert] = "Could not send friend request"
    end
    redirect_to root_path
  end

  def accept_friend_request
    @friendship = Friendship.find(params[:id])
    if @friendship.update(status: params[:status])
      flash[:notice] = "Friend request #{params[:status]}"
    else
      flash[:alert] = "Could not accept friend request"
    end
    redirect_to root_path
  end

  def remove_request
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      flash[:notice] = "Friend request removed"
    else
      flash[:alert] = "Could not remove friend request"
    end
    redirect_to root_path
  end

  def friends_by_accepting
    Friendship.accepted(current_user.id).map do |accepted|
      User.find(accepted.sender_id)
    end
  end

  def friends_by_sending
    Friendship.accepted_send(current_user.id).map do |accepted|
      User.find(accepted.receiver_id)
    end
  end

  def friends
    @friends = friends_by_accepting + friends_by_sending
  end

  def remove_friend
    friendship = Friendship.find_by(sender_id: current_user.id, receiver_id: params[:id]) || Friendship.find_by(sender_id: params[:id], receiver_id: current_user.id)
    friendship.destroy
    flash[:notice] = "Friend removed"
    redirect_to friends_path
  end
end
