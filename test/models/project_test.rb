require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

  def setup
    super
    @project = Project.new name: "test", user_id: 1, id: 10010
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
    assert Datafolder::Env.exist? "1/10010"
    assert Datafolder::Env.exist? "1/10010/asset"
    assert Datafolder::Env.exist? "1/10010/index.ipynb"
  end

  test "project destroy" do
    @project.destroy
    assert_not Datafolder::Env.exist? "1/10010"
  end

end
