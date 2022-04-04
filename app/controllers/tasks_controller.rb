
class TasksController < ApplicationController

    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
    end

    def show
        # @comments = @task.comments
        # @commnts = [content: "comment text", user_id] 
        @board = Board.find(params[:board_id])
        # @task = Task.find(params[:id])
        @task = @board.tasks.find(params[:id])

        @comments = @task.comments
    end

    def new
        board = Board.find(params[:board_id])
        @task = board.tasks.build
    end

    def create
        board = Board.find(params[:board_id])
        @task = board.tasks.build(task_params)
        if @task.save
            redirect_to board_path(board), notice: 'タスクを追加'
        else
            flash.now[:error] = '追加できましぇん'
            render :new
        end
    end

    def edit
        @board = Board.find(params[:board_id])
        @task = current_user.tasks.find(params[:id])
    end

    def update
        @board = Board.find(params[:board_id])
        @task = current_user.tasks.find(params[:id])
        if @task.update(task_params)
            redirect_to board_task_path(board_id: @board.id, id: @task.id), notice: '更新できました'
        else
            flash.now[:error] = '更新できましぇん'
            render :edit
        end
    end

    def destroy
        board = Board.find(params[:board_id])
        task = current_user.tasks.find(params[:id])
        task.destroy!
        redirect_to board_path(board)
    end

    private 
        def task_params
            params.require(:task).permit(:title, :content, :deadline, :eyecatch, :user_id)
                        .merge(user_id: current_user.id)    
        end

        

end