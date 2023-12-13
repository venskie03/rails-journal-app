class TaskController < ApplicationController
  before_action :authenticate_user!
  def index
    @category = Category.find(params[:category_id])
    @tasks = @category.tasks.includes(:category)
  end
  def new
    @category = Category.find(params[:category_id])
    @task = @category.tasks.build
  end
  def show
    @task = Task.find(params[:id])
  end
  def edit
    @task = Task.find(params[:id])
  end
  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      flash[:success_updated] = ["Successfully Updated Task #{@task.task_name}"]
      redirect_to '/task/:id/edit'
    else
      flash[:error_update] = ["Failed to Updated Task #{@task.task_name}"]
    end
  end
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to "/tasks/:category_id"
  end

  def create
    @category = Category.find(params[:category_id])
    @task = @category.tasks.build(task_params)

    if @task.save
      redirect_to category_tasks_path(@category), notice: "Task Successfully Created"
    else
      flash[:error_creating] = [@task.errors.full_messages.join(' and ')]
      render :new
    end
  end

  private
  def authenticate_user!
    redirect_to '/' unless current_user
  end
  def task_params
    params.require(:task).permit(:task_name, :task_description, :task_date)
  end
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
