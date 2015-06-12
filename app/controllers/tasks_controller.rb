class TasksController < ApplicationController
  before_action :set_company
  before_action :set_task, only: %i(update destroy show)

  def index
    @tasks = @company.tasks
  end

  def create
    @task = @company.tasks.create task_params
    render status: 201
  end

  def show
  end

  def update
    @task.update_attributes task_params
  end

  def destroy
    @task.destroy
  end

  private

  def task_params
    params.require(:task).permit :name
  end

  def set_company
    @company = Company.find params[:company_id]
  end

  def set_task
    @task = @company.tasks.find params[:id]
  end
end
