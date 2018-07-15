require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    Datafolder::Env.init
    @user = User.new name: "Example User",email: "user@example.com", password: "foobar", password_confirmation: "foobar", id: 10086    
    @user.save
    @project = Project.new name: "test", user_id: @user.id, id: 10010
    @user.create_home
  end

  test "project should be valid" do
    assert @project.valid?
  end

  test "user shoudle be present" do
    @project.user_id = nil
    assert_not @project.valid?
  end
  
  test "project directory create" do
    @project.create_home
    assert Datafolder::Env.exist? "10086/10010"
    assert Datafolder::Env.exist? "10086/10010/asset"
    assert Datafolder::Env.exist? "10086/10010/index.ipynb"
  end

  def teardown
    Datafolder::Env.drop
  end
end
