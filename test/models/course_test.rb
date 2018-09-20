require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    super
    @course = courses :one
    @group = Group.find @course.group_id
    @users = @group.users
  end

  test 'should clear imported projects when destroy' do
    @course.destroy
    @users.each do |u|
      assert_empty Project.where user_id: u, pushed_by: @course
    end
  end

  test 'should push project after create' do
    course = Course.create group_id: @group.id, project_id: 4
    @users.each do |u|
      assert_not_nil u.projects.find_by pushed_by: course
    end
  end
end
