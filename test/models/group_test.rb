require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    # super
    @user = users(:test)
    @group = groups("one")
  end

  test "group create test" do
    group = Group.create name: "test", user_id: @user.id
    gr = GroupRelationship.find_by group_id: group.id, user_id: @user.id
    assert_not gr.nil?
  end

  test "group_course_number" do
    assert_equal @group.all_courses.count, 0
    assert_equal groups("two").all_courses.count, 1
  end

  test "group_add member" do
    # todo test code
    user = User.find 12
    assert_difference "GroupRelationship.count",1 do
      before_join = Project.where(user_id: user).count
      assert @group.join user
      assert_equal Project.where(user_id: user).count, before_join
    end

    assert_difference "GroupRelationship.count",0 do
      assert_not @group.join user
    end
  end

  test "group_destroy" do
    @group.destroy
    assert_empty GroupRelationship.where(group_id: @group)
    assert_empty Course.where(group_id: @group)
  end
end

