module GroupsHelper
  def groups_for(user, dic)
    __group_relationships = GroupRelationship.where(user_id: user.id)
    groups = []

    if dic[:role] == "owner"
      __group_relationships.each do |gr|
        group = Group.find gr.group_id
        groups.append group if group.user_id == user.id
      end
    elsif dic[:role] == "member"
      __group_relationships.each do |gr|
        group = Group.find gr.group_id
        groups.append group unless group.user_id == user.id
      end
    elsif dic[:role] == "all"
      __group_relationships.each do |gr|
        group = Group.find gr.group_id
        groups.append group
      end
    else
      raise "no such role"
    end

    return groups
  end

  def invitation_token(group)
    now = Time.now.to_i
    if group.invitation_token.nil?
      return "None"
    else
      t = group.invitation_token
      _, timestamp = Base64.decode64(t).split '?'
      if now - timestamp.to_i >= 7200
        return "None"
      else
        return t
      end
    end
  end
      
      
end
