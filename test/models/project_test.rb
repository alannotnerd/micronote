require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users(:Man)    
    @project = Project.new name: "test", user_id: @user.id
  end

  test "project should be valid" do
    assert @project.valid?
  end

  test "user shoudle be present" do
    @project.user_id = nil
    assert_not @project.valid?
  end
end
