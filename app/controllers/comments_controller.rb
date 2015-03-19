class CommentsController < ApplicationController
  before_action :require_user, :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user

    if @comment.save
      flash[:notice] = "Your comment was added."
      redirect_to post_path(@post)
    else
      flash[:error] = "Comment field cannot be blank."
      redirect_to :back
    end
  end

  def vote
    @comment = @post.comments.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])

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

  def set_post
    @post = Post.find_by slug: params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end