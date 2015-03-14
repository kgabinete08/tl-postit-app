class CommentsController < ApplicationController
  before_action :require_user, :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      flash[:warning] = "Comment field cannot be blank."
      redirect_to :back
    end
  end

  def vote
    @comment = @post.comments.find(params[:id])

    vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

    if vote.valid?
      flash[:notice] = "Your vote was added."
    else
      flash[:error] = "You can only vote on this comment once."
    end

    redirect_to :back
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end