require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @course = courses(:one)
    @group = Group.find @course.group_id
    @users = Group.all
  end

  test "should clear imported projects" do
    @course.destroy
    @users.each do |u|
      assert_empty Project.where user_id: u, pushed_by: @course
    end
  end
end
