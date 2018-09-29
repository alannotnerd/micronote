class CoursesController < ApplicationController

  def new
    @course = Course.new
    if params.key?(:group_id)
      @group = Group.find(params[:group_id])
      unless @group.owned_by?(current_user)
        flash[:danger] = 'Make sure you have access permission.'
        redirect_to root_url
      end
    else
      flash[:danger] = 'illegal url request'
      redirect_to root_url
    end
  end

  def create
    # redirect_to root_url unless params[:user_id] == current_user.id
    if params[:user_id].to_i != current_user.id
      flash[:error] = 'Something insecure happened'
      redirect_to root_url
      return
    end
    project = Project.find_by(user_id: current_user.id, name: params[:project_name])
    group = Group.find params[:group_id]
    if project.nil?
      flash[:error] = 'project not found.'
      redirect_to new_course_path+"?group_id=#{group.id}"
      return
    end
    if group.add_course(project)
      flash[:info] = 'Auto import working background. This may cost several minutes.'
      redirect_to group
      return
    else
      flash[:error] = 'Course Has exist'
      render group
    end
    # redirect_to group
  end

  def show
    @course = Course.find params[:id]
    unless @course.group.owned_by?(current_user)
      flash[:danger] = 'Only group owner can access.'
      redirect_to group_path(@course.group)
    end
  end

  def close
    @course = Course.find params[:id].to_i
    @course.toggle_close
    # cause open state has changed.
    flash[:info] = "Course #{@course.origin_project.name} #{@course.opened? ? 'opened':'closed'}!"
    redirect_to group_path(@course.group)
  end

  def destroy
    @course = Course.find params[:id]
    @course.destroy
    flash[:info] = 'Course destroy process invoking'
    redirect_to group_path(@course.group)
  end
  private
    def course_params
      params.require(:course).permit(:project_name, :group_id)
    end
end
