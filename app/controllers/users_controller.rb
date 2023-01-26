class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
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

  def show
    @user = User.find(params[:id])
    @friends = friends_by_accepting + friends_by_sending
  end
end
