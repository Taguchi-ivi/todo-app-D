class CommentsController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create]

    def new
        @board = Board.find(params[:board_id])
        @task = Task.find(params[:task_id])
        @comment = @task.comments.build
    end

    def create
        board = Board.find(params[:board_id])
        task = Task.find(params[:task_id])
        @comment = task.comments.build(comment_params)
        if @comment.save
            redirect_to board_task_path(board_id: board, id: task), notice: 'コメント追加'
        else
            flash.now[:error] = '追加できましぇん' 
            render :new
        end
    end

    private

        def comment_params
            params.require(:comment).permit(:content, :user_id).merge(user_id: current_user.id)
        end
end