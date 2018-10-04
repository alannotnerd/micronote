class PushProjectJob < ActiveJob::Base
  queue_as :default

  def perform(id)
    # Do something later
    course = Course.find id
    course.group.group_relationships.where(level: 10).each do |gr|
      Project.import course.project.id, gr.user_id, course.id
    end
  end
end
