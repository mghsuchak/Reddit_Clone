class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.new(comment_params)
    @comment.user = current_user
      if @comment.save
       redirect_to @link, notice: 'Comment was successfully created.'
      else
      render action: "new" 
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @link = Link.find(params[:link_id])
    @comment=@link.comments.find(params[:id])
    @comment.destroy
    redirect_to link_path(@link), notice: 'Comment was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:link_id, :body, :user_id)
    end
end
