# #GroupController
# Deal all request to [Group] model.
class GroupsController < ApplicationController
  def new
    @group = Group.new
    @user = User.find session[:user_id]
  end

  def create
    @user = User.find(params[:user_id])
    if @user.is_admin?
      @group = Group.new(name: params[:group][:name], user_id: @user.id)
      if @group.save
        redirect_to groups_path
      else
        render 'new'
      end
    else
      flash[:error] = "you doesn't has permission to create group"
      redirect_to @user
    end
  end

  def show
    @group = Group.find(params[:id])
  end

  def index
    if current_user.nil?
      redirect_to login_path
      flash[:info] = 'Please log in first'
    end
    @user ||= User.find session[:user_id]

    _groups = GroupRelationship.where(user_id: @user.id)
  end

  def gen_invitation
    now = Time.now
    @group = Group.find params[:id]
    token = Base64.encode64("#{@group.id}?#{now.to_i}").chomp
    @group.remember_token token
    render :json => {id: @group.id, token: token, datetime: now}
  end

  def proc_invitation
    now = Time.now.to_i
    token = params[:token]
    s = Base64.decode64(token)
    group_id, timestamp = s.split '?'
    group = Group.find group_id
    if group.invitation_token != token || now - timestamp.to_i >= 7200
      flash[:danger] = 'Invalid Invitation Token Or Token expired'
      redirect_to root_path
    else
      unless group.join(current_user)
        flash[:danger] = "You're already in group"
        redirect_to groups_path
        return
      end
      flash[:info] = 'Success! waiting for importing projects'
      redirect_to groups_path
    end
  end

  def rm_user
    @gr = GroupRelationship.find params[:id]
    if @gr.group.owned_by?(current_user) and @gr.group.user?(@gr.user)
      @gr.group.rm_user @gr.user
      flash[:info] = "user #{@gr.user.name} removed."
    else
      flash[:danger] = "Make sure you're administrator and User is in group"
    end

    redirect_to group_path(@gr.group)
  end

  private
    def group_param
      params.require(:group).permit(:name, :user_id)
    end
end
