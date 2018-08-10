class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end
  def show
    puts session[:user_id]
    @project = Project.find(params[:id])
  end

  def create
    @project = Project.new(params)
  end

  def edit
    @project = Project.find(params[:id])
  end

  private
    def user_params
      params.require(:project).permit(:name, :user_id)
    end
end
