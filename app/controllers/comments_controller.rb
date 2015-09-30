class CommentsController < ApplicationController
  def create
    comment = current_user.comments.build(comment_params)
    comment.save!
    redirect_to seminar_project_path(id: comment.target_id)
  end

  private

  def comment_params
    params.require(:comment).permit(:target, :target_id, :content)
  end
end
