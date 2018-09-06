class Course < ActiveRecord::Base
  def level_of(user)
    group = Group.find group_id
    return GroupRelationship.find_by(group_id: group_id, user_id: user.id).level
  end
end
