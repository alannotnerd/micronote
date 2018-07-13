require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
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

  test "project api test" do
    sample = JSON.parse('{"type":"notebook","content":{"cells":[{"metadata":{},"cell_type":"markdown","source":"# Sample\nThis is sample markdown cell"}],"metadata":{"kernelspec":{"name":"python3","display_name":"Python 3","language":"python"},"language_info":{"name":"python","version":"3.6.5","mimetype":"text/x-python","codemirror_mode":{"name":"ipython","version":3},"pygments_lexer":"ipython3","nbconvert_exporter":"python","file_extension":".py"}},"nbformat":4,"nbformat_minor":2}}')
    res = Project.api "get", "contents", @user.home_path
    res = Project.api "post", "contents", @user.home_path, type: "notebook"
    assert_equal res["path_without_env"], "/10086/Untitled.ipynb"
    res = Project.api "patch", "contents", res["path_without_env"], path: "test/10086/index.ipynb"
    assert_equal res["path_without_env"], "/10086/index.ipynb"
    res = Project.api "put", "contents", res["path_without_env"], sample
    # RestClient.put("http://localhost:8888/api/contents/test"+res["path_without_env"], sample.to_json)
  end

  test "project directory create" do
    @project.create_home
    res = Project.api "get", "contents", @user.home_path
    result = false
    res["content"].each do |content|
      puts content["name"]
      result = true if content["name"] == @project.id.to_s
      break if result
    end
    assert result
  end

  def teardown
    FileUtils.rm_rf '/data/rails/test' if Dir.exists?('/data/rails/test')
  end
end
