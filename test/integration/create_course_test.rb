require 'test_helper'

class CreateCourseTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users :Man
    log_in_as @user
  end

  test "should create_course" do
    
  end

end
