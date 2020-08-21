class Api::TagsController < Api::ApplicationController
  before_action :set_tag, only: [:show, :edit, :update, :destroy]



 
 
  # POST /tags
  def create
    @tag = Tag.new(tag_params)

      if @tag.save
        render json: @tag, status: :created
      else
        render json: {errors: @tag.errors}, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /tags/1
  # PATCH/PUT /tags/1.json
  def update
      if @tag.update(update_tag_params)
        render json: @tag, status: :ok
      else
        render json: {errors: @tag.errors}, status: :unprocessable_entity
      end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tag_params
      params.require(:tag).permit(:description , :post_id)
    end

    def update_tag_params
      params.require(:tag).permit(:description) # user can't change tag's post
    end

end
