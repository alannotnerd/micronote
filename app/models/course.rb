class Course < ActiveRecord::Base
  before_destroy :clean_up
  belongs_to :group
  belongs_to :project
  after_create :push_project
  has_many :projects, foreign_key: :pushed_by
  def level_of(user)
    # group = Group.find group_id
    GroupRelationship.find_by(group_id: group_id, user_id: user.id).level
  end

  def clean_up
    CourseCleanupJob.perform_now self
  end

  # def projects
  #   Project.where pushed_by: self
  # end
  #
  # def group
  #   Group.find group_id
  # end

  def origin_project
    Project.find project_id
  end

  def push_project
    # TODO: re-push
    PushProjectJob.perform_later self
  end

  def toggle_close
    if opened
      update_attribute :opened, false
      update_attribute :expire_date, Time.zone.now
    else
      update_attribute :opened, true
      update_attribute :begin_date, Time.zone.now
      update_attribute :expire_date, nil
    end
    return {state: opened, id: id}
  end
end
