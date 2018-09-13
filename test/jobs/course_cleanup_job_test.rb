require 'test_helper'

class CourseCleanupJobTest < ActiveJob::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @course = courses :one
  end
  test "clean up" do
    CourseCleanupJob.perform_now group_id: @course.group_id, project_id: @course.project_id
    assert_empty Project.where(pushed_by: @course.project_id)
  end
end
