class VotesController < ApplicationController
  before_action :set_post

  def create
    @vote = @post.votes.new(vote_params)
    @vote.user = current_user
    if @vote.save
      redirect_to :back
    else
      redirect_to :back,
      :notice => "You have already voted for this"
    end
  end

  def destroy
    @vote.destroy
  end

private

    def vote_params
    params.require(:vote).permit(:upvote, :downvote)
    end

  def set_post
    @post = Post.find(params[:post_id])
  end


end
