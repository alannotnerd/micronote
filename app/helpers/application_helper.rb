module ApplicationHelper
  def full_title(page_title = '')
    base_title = "MicroHard"
    if page_title.empty?
	base_title
    else
      page_title + "| "+base_title
    end 
  end

  def gravatar_for(user, options= { size: 80 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?size=#{size}"
    image_tag(gravatar_url, alt: user.name, class:"gravatar")
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def current_user?(user)
    user == current_user
  end

end
