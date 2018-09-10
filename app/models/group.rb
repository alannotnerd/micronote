class Group < ActiveRecord::Base
  belongs_to :user
  has_many :group_relationship
  after_create :create_relationship

  def create_relationship
    # user = User.find user_id
    GroupRelationship.create(group_id: id, user_id: user_id, level: 1)
  end

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
    return cs
  end

  def join(user)
    gr = GroupRelationship.new user_id: user.id, group_id: id
    # if gr.save
  end

  def remember_token token
    update_attribute :invitation_token, token
  end
end
