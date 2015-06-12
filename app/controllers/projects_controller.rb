class ProjectsController < ApplicationController
  before_action :set_company
  before_action :set_project, only: %i(update destroy show)

  def index
    @projects = @company.projects
  end

  def create
    @project = @company.projects.create project_params
    render status: 201
  end

  def show
  end

  def update
    @project.update_attributes project_params
  end

  def destroy
    @project.destroy
  end

  private

  def project_params
    params.require(:project).permit :name
  end

  def set_company
    @company = Company.find params[:company_id]
  end

  def set_project
    @project = @company.projects.find params[:id]
  end
end
