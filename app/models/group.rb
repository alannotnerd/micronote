class Group < ActiveRecord::Base
  belongs_to :user
  has_many :group_relationship
  after_create :create_relationship
  before_destroy :clean_up

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

  def clean_up
    self.all_courses.each do |c|
      c.destroy
    end
    self.all_relationships.each do |gr|
      gr.destroy
    end
  end

  def all_relationships
    return GroupRelationship.where group_id: id
  end

  def all_courses
    cs = Course.where group_id: id
    return cs
  end

  def add_course project_name
    # TODO
  end

  def rm_user(user)
    # TODO
  end

  def join(user)
    gr = GroupRelationship.new user_id: user.id, group_id: id
    if GroupRelationship.find_by(user_id:user.id, group_id: id).nil?
      gr.save
      return true
    else
      return false
    end
  end

  def remember_token token
    update_attribute :invitation_token, token
  end
end
