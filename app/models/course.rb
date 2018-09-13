class Course < ActiveRecord::Base
  before_destroy :clean_up
  def level_of(user)
    group = Group.find group_id
    return GroupRelationship.find_by(group_id: group_id, user_id: user.id).level
  end

  def clean_up
    CourseCleanupJob.perform_now self
  end
end
