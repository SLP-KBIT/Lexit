class CommentsController < ApplicationController
  def create
    comment = Comment.new(comment_params)
    comment.user_id = current_user.id
    comment.save!
    redirect_to seminar_project_path(id: comment.target_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:target, :target_id, :content)
  end
end
