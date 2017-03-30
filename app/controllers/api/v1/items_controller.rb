module Api::V1
  class ItemsController < ApplicationController
    before_action :set_todo, only: [:index, :create]
    before_action :set_item, only: [:show, :update, :destroy]

    def index
      render json: (@todo.items)
    end
    def create
        @todo.items.create!(item_params)
        @item = @todo.items.last
        render json: @item
    end
    def show
      render json: @item
    end
    def update
      @item.update(item_params)
      head :no_content
    end
    def destroy
      @item.destroy
      head :no_content
    end
    private
    def item_params
      params.permit(:name, :done)
    end
    def set_todo
      @todo = Todo.find(params[:todo_id])
    end

    def set_item
      @item = Item.find(params[:id])

    end
  end
end
