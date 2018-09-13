require 'test_helper'

class GroupRelationshopCleanupJobTest < ActiveJob::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @gr = group_relationships :one
  end
  test "cleanup" do
    GroupRelationshopCleanupJob.perform_now @gr
    cs = Group.find(@gr.group_id).all_courses
    cs.each do |c|
      assert_empty Project.where(user_id: @gr.user_id, pushed_by: c.project_id)
    end
  end
end
