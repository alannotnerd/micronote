class Group < ActiveRecord::Base
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :group_relationships
  has_many :courses
  after_create :create_relationship
  before_destroy :clean_up

  def create_relationship
    # user = User.find user_id
    GroupRelationship.create(group_id: id, user_id: user_id, level: 1)
  end

  def owned_by?(user)
    user_id == user.id
  end

  def clean_up
    courses.each(&:destroy)
    group_relationships.each(&:destroy)
  end

  def add_course project
    Course.create project_id: project.id, group_id: id, begin_date: Time.zone.now
  end

  def rm_user(user)
    gr = group_relationships.find_by user_id: user
    return false if gr.nil?

    gr.destroy
    true

  end

  def users
    res = []
    group_relationships.each do |gr|
      res.append(gr.user) unless gr.level == 1
    end
    res
  end

  def join(user)
    gr = GroupRelationship.new user_id: user.id, group_id: id
    return false unless
        GroupRelationship.find_by(user_id:user.id, group_id: id).nil?

    gr.save
    courses.each do |c|
      Project.import c.project.id, gr.user.id, c.id
    end
    true
  end

  def user?(user)
    !group_relationships.find_by(user_id: user).nil?
  end

  def remember_token(token)
    update_attribute :invitation_token, token
  end
end
