class CourseCleanupJob < ActiveJob::Base
  queue_as :default

  def perform(course)
    # Do something later
    users = course.group.users
    users.each do |u|
      p = Project.find_by(user_id: u, pushed_by: course)
      p.destroy unless p.nil?
    end
  end
end
