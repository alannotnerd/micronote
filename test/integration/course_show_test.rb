require 'test_helper'

class CourseShowTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = users :Man
    log_in_as @user
  end

  test 'show_course_view' do
    get course_path(courses :one)
    assert_redirected_to group_path(groups :two)
    # assert_template "shared/_project_comb"
  end
end
