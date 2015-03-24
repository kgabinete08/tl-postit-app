class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:index, :show, :vote]
  before_action :require_correct_user, only: [:edit, :update]

  def index
    @posts = Post.all
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    
    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_path, notice: "Your post was created." }
        format.js
      else
        format.html { render 'new' }
        format.js
      end
    end
  end

  def edit; end

  def update
    if @post.update(post_params)
      flash[:notice] = "The post was updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])
    
    respond_to do |format|
      if @vote.valid?
        format.html { redirect_to :back, notice: "Your vote was added." }
        format.js
      else
        format.html { redirect_to :back, alert: "You can only vote once." }
        format.js
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
    @post = Post.find_by slug: params[:id]
  end

  def require_correct_user
    if @post.creator != current_user
      flash[:error] = "You do not have the permission to do that."
      redirect_to root_path
    end unless current_user.admin?
  end
end

