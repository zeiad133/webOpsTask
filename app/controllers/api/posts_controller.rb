class Api::PostsController < Api::ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    render json: @posts, status: :ok
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    render json: @post, status: :ok
  end


  # POST /posts
  # POST /posts.json
  def create
    # print("aaa" , Sidekiq::Cron::Job)
    ActiveRecord::Base.transaction do 
    @post = Post.new(post_params)
    @post.user = current_user
 

    Comment.add_comment_to_post(@post , post_params[:comment_description])
    Tag.add_tag_to_post(@post , post_params[:tag_description])


      if @post.save!
        render json: @post, status: :created
      else
        render json: {errors: @post.errors}, status: :unprocessable_entity 
    end
  end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    authorize @post

      if @post.update(post_params)
        render json: @post, status: :ok
      else
        render json: {errors: @post.errors}, status: :unprocessable_entity 
      end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    authorize @post
    @post.destroy
    render json: @post, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :body , :comment_description , :tag_description)
    end



end
