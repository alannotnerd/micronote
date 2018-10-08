class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end
  def show
    @project = Project.find(params[:id])
    if current_user.nil?
      flash["error"] = "Please Log in first"
      redirect_to root_url
    elsif !@project.accessible? current_user
      flash["error"] = "Make sure have access permission"
      redirect_to root_url
    end
  end

  def create
    @project = Project.new(project_params)
    # puts project_params
    if @project.save
      @user = User.find @project.user_id
      redirect_to @user
    else
      redirect_to root_url
    end
  end

  def upload
    @project = Project.find params[:id]
    res = @project.save_asset(params[:upload])
    render json: res
  end

  def edit
    @project = Project.find(params[:id])
    if not @project.editable?(current_user)
      flash[:danger] = "Sorry, project is closed or you don't have access permission."
      redirect_to root_url
    elsif current_user.nil?
      flash[:error] = "Please Log in first"
      redirect_to root_url
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :user_id)
  end

  def origin_user(project)
    if project.pushed_by.nil?
      User.find project.user_id
    else
      course_id = project.pushed_by
      origin_project = Project.find Course.find(course_id).project_id
      User.find origin_project.user_id
    end
  end
end
