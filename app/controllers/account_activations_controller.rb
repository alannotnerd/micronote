class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      user.create_home
      _flowee = User.find_by(email: "haocai@whu.edu.cn")
      unless _flowee.nil?
        Project.where(user_id: _flowee.id).each do |p|
          Project.import p.id, user.id
        end 
      end
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else 
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
