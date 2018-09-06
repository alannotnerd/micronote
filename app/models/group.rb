class Group < ActiveRecord::Base
  belongs_to :user
  has_many :group_relationship

  def owner
    User.find user_id
  end

  def isOwnedBy(user)
    user_id == user.id
  end

  def all
    __gr = GroupRelationship.where group_id: id
    users = []
    __gr.each do |g|
      _user = User.find g.user_id
      users.append _user
    end
    return users
  end

  def all_courses
    cs = Course.where group_id: id
    # projects = []
    # __cs.each do |c|
    #   _project = Project.find c.project_id
    #   projects.append _project
    # end
    return cs
  end

  def remember_token token
    update_attribute :invitation_token, token
  end
end
