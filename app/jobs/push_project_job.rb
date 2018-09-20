class PushProjectJob < ActiveJob::Base
  queue_as :default

  def perform(course)
    # Do something later
    course.group.group_relationships.where(level: 10).each do |gr|
      Project.import course.project.id, gr.user_id, course.id
    end
  end
end
