class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  
  def index
    @task = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    
    if @task.save
      flash[:success] = 'OK！'
      redirect_to @task
    else
      flash.now[:danger] = '記録失敗'
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:id] = 'OK!'
      redirect_to @task
    else
      flash.now[:danger] = '更新失敗'
      render :edit
    end
  end

  def destroy
    @task.destroy
    
    flash[:success] = 'OK!'
    redirect_to tasks_url
  end
  
  
  private
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
end