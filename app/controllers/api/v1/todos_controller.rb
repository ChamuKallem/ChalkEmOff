module Api::V1
  class TodosController < ApiController
    before_action :set_todo, only: [:show, :update, :destroy]
    def index
      @todos = Todo.all
      render json: @todos
    end
    def create
      @todo = Todo.create!(todo_params)
      render json: @todo
    end
    def show
      render json: @todo
    end
    def update
      @todo.update(todo_params)
      head :no_content
    end
    def destroy
      @todo.destroy
      head :no_content
    end

    private
    def todo_params
      params.permit(:title, :complete, :user_id)
    end
    def set_todo
      @todo = Todo.find(params[:id])
    end

  end
end
