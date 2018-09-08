class CoursesController < ApplicationController
  def new
    @course = Course.new
    if params.key?(:group_id)
      @group = Group.find params[:group_id]
    end
  end

  def create
    # redirect_to root_url unless params[:user_id] == current_user.id
    if params[:user_id].to_i != current_user.id
      flash[:error] = "Something insecure happened"
      redirect_to root_url
      return
    end
    project = Project.find_by(user_id: current_user.id, name: params[:project_name])
    group = Group.find params[:group_id]
    if project.nil?
      flash[:error] = "project not found."
      redirect_to new_course_path+"?group_id=#{group.id}"
      return
    end
    if Course.create project_id: project.id, group_id: group.id, begin_date: Time.now
      _re = GroupRelationship.where(group_id: group.id)
      name = project.name
      _re.each do |r|
        user = User.find r.user_id
        if Project.find_by(user_id: user.id, name: name).nil?
          Project.import project.id, user.id, Course.find_by(group_id: group.id, project_id:project.id).id
        end
      end
      flash[:info] = "<strong>Auto import working background</strong>. This may cost serveral minutes."
      redirect_to group
      return
    else
      flash[:error] = "Course Has exist"
      render group
    end
    # redirect_to group
  end

  def show
    @course = Course.find params[:id]
    @projects = Project.where(pushed_by: @course.id)
  end

  private
    def course_params
      params.require(:course).permit(:project_name, :group_id)
    end
end
