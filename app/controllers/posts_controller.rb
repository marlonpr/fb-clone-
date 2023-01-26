class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]

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

  def index
    @comment = Comment.new
    current_user_posts = current_user.posts
    friends_posts = Post.where(user_id: friends)
    all_posts = current_user_posts + friends_posts
    @posts = all_posts.sort_by(&:created_at).reverse
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content, :title)
  end
end
