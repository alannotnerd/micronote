require 'test_helper'

class CourseCleanupJobTest < ActiveJob::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @course = courses :one
  end
  test "clean up" do
    CourseCleanupJob.perform_now @course
    assert_empty Project.where(pushed_by: @course)
  end
end
