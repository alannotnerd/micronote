require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    Datafolder::Env.init
    @user = users(:test)
    @user.create_home
    @project = Project.create name: "test", user_id: @user.id
  end

  test "group create test" do
    group = Group.create name: "test", user_id: @user.id
    gr = GroupRelationship.find_by group_id: group.id, user_id: user.id
    assert_not gr.nil? || gr.empty?
  end

  test "group_destroy_test" do
    # todo 
  end
end

