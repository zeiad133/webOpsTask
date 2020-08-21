class Api::CommentsController < Api::ApplicationController
    before_action :set_comment, only: [:show, :edit, :update, :destroy]
  


    # comment /comments
    # comment /comments.json
    def create
      @comment = Comment.new(comment_params)
        if @comment.save
          render json: @comment, status: :created
        else
          render json: {errors: @comment.errors}, status: :unprocessable_entity 
      end
    end


    # PATCH/PUT /comments/1
    # PATCH/PUT /comments/1.json
    def update
      authorize @comment
  
        if @comment.update(comment_params)
          render json: @comment, status: :ok
        else
          render json: {errors: @comment.errors}, status: :unprocessable_entity 
        end
    end
  
    # DELETE /comments/1
    # DELETE /comments/1.json
    def destroy
      authorize @comment
      @comment.destroy
      render json: @comment, status: :ok
    end
  
    private
      # Use callbacks to share common setup or constraints between actions.
      def set_comment
        @comment = Comment.find(params[:id])
      end
  
      # Never trust parameters from the scary internet, only allow the white list through.
      def comment_params
        params.require(:comment).permit(:description , :post_id)
      end

      def comment_update_params
        params.require(:comment).permit(:description) #User can't move comment from post to another post
      end
  end
  