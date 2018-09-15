class GroupRelationshopCleanupJob < ActiveJob::Base
  queue_as :default

  def perform(group_relationship)
    # Do something later
    # kwarg = args[-1]
    gr=group_relationship
    cs = Group.find(gr.group_id).courses
    cs.each do |c|
      p = Project.find_by(pushed_by: c, user_id: gr.user_id)
      p.destroy unless p.nil?
    end
  end
end
