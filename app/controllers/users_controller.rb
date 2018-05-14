class UsersController < ApplicationController
  #before_create :create_activation_digest
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  def new
    @user=User.new
  end

  def create
    @user=User.new(user_param)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your mail to activate your account."
      redirect_to root_url
      #log_in @user
      #flash[:success] = "Welcome to MicroHard!"
      #redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user=User.find(params[:id])
  end
  
  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update_attributes(user_param)
      flash[:success] = "Successful update!"
      redirect_to @user
      #do somethins
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  private

    def user_param
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        store_location
        redirect_to login_url
      end
    end
    
    def is_current_user?
      current_user? @user
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless is_current_user?
    end

    def admin_user
      redirect_to root_url unless current_user.admin?
    end

end
