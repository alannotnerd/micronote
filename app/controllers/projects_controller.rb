class ProjectsController < ApplicationController
  def new
    @project = Project.new
  end
  def show
    @project = Project.find(params[:id])
    if current_user.nil?
      flash["error"] = "Please Log in first"
      redirect_to root_url
    elsif @project.user_id != current_user.id
      if @project.pushed_by.nil? || Course.find(@project.pushed_by).level_of(current_user) > 5
        flash["error"] = "Make sure have access permission"
        redirect_to root_url
      end
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

  def edit
    @project = Project.find(params[:id])

    if current_user.nil?
      flash[:error] = "Please Log in first"
      redirect_to root_url
    elsif @project.user_id != current_user.id
      if @project.pushed_by.nil? || Course.find(@project.pushed_by).level_of(current_user) > 5
        flash["error"] = "Make sure have access permission"
        redirect_to root_url
      end
    end
  end

  private
    def project_params
      params.require(:project).permit(:name, :user_id)
    end

    def origin_user(project)
      if project.pushed_by.nil?
        return User.find project.user_id
      else
        # todo
        course_id = project.pushed_by
        origin_project = Project.find Course.find(course_id).project_id
        return User.find origin_project.user_id
      end                               
    end
end
