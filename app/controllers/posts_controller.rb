class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    
  end

  def edit
    
  end

  def update
    
  end

  private

  # def post_params
  #   params.require(:post).permit([:new, :create, :edit, :update])
  # end
  
end
