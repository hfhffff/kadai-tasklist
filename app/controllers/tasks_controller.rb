class TasksController < ApplicationController
  def index
    @task = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    
    if @task.save
      flash[:success] = 'OK！'
    else
      flash.now[:danger] = '記録失敗'
      render :new
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:id] = 'OK!'
      redirect_to @task
    else
      flash.now[:danger] = '更新失敗'
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = 'OK!'
    redirect_to messages_url
  end
  
  private
  
  def task_params
    params.require(:task).permit(:content)
  end

end