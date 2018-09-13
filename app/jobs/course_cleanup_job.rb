class CourseCleanupJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Do something later
    users = Group.find(args[-1][:group_id]).all
    users.each do |u|
      p = Project.find_by(user_id: u, pushed_by: args[-1][:project_id])
      p.destroy unless p.nil?
    end
  end
end
