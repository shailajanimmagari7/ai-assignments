class TodosController < ApplicationController
  def index
    @todos_grouped_by_month = Todo
      .order(created_at: :desc)
      .group_by { |todo| todo.created_at.strftime("%B %Y") }

    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.completed = false
    if @todo.save
      redirect_to root_path
    else
      @todos_grouped_by_month = Todo.order(created_at: :desc).group_by { |todo| todo.created_at.strftime("%B %Y") }
      render :index, status: :unprocessable_entity
    end
  end

  def update
    @todo = Todo.find(params[:id])
    @todo.update(completed: !@todo.completed)
    redirect_to root_path
  end

  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to root_path
  end

  private

  def todo_params
    params.require(:todo).permit(:title)
  end
end
