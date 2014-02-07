class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    # @unordered_posts = Post.all
    params[:sort_by] ||= 'upvote_count'

    # if params[:sort_by] != 'created_at' or params[:sort_by] != 'upvote_count'
    #   params[:sort_by] = 'upvote_count'
    # end

    @posts = 
    Post.joins("LEFT OUTER JOIN votes ON votes.post_id = posts.id").
    select('posts.*, count(votes.upvote) as upvote_count').
    where('upvote = true or upvote is null').
    group('posts.id, votes.post_id'). 
    order("#{params[:sort_by]} desc")
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find_by_id(params[:id])
    @comments = @post.comments
  end

  # GET /posts/new
  def new
    @post = current_user.posts.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { render action: 'new' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = current_user.posts.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def post_params
    params.require(:post).permit(:title, :content, :image)
    end

end
