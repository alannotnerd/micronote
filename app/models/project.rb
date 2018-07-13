class Project < ActiveRecord::Base
  belongs_to :user
  after_create :create_home
  validates :user_id, presence: true

  def create_home
    user = User.find self.user_id 
    home = user.home_path
    sample = JSON.parse('{"type":"notebook","content":{"cells":[{"metadata":{},"cell_type":"markdown","source":"# Sample\nThis is sample markdown cell"}],"metadata":{"kernelspec":{"name":"python3","display_name":"Python 3","language":"python"},"language_info":{"name":"python","version":"3.6.5","mimetype":"text/x-python","codemirror_mode":{"name":"ipython","version":3},"pygments_lexer":"ipython3","nbconvert_exporter":"python","file_extension":".py"}},"nbformat":4,"nbformat_minor":2}}')
    @absolute_path = "#{home}/#{self.id}"
    res = Project.api "post", "contents", home, type: "directory"
    Project.api "patch", "contents", res["path_without_env"], {path: replace_last(res["path"], self.id)}
    res = Project.api "post", "contents", @absolute_path, type: "notebook"
    res = Project.api "patch", "contents", res["path_without_env"], path: replace_last(res["path"], "index.ipynb")
    res = Project.api "put", "contents", res["path_without_env"], sample
    res = Project.api "post", "contents", @absolute_path, type: "directory"
    res = Project.api "patch", "contents", res["path_without_env"], path: replace_last(res["path"], "asset")
  end

  def rm_home
    user = User.find self.user_id
    home = user.home_path
    Project.api "delete", "contents", home+self.name
  end

  def Project.api(method, type, path="", payload={})
    if payload.empty?
      # response = HTTP.send(method,"http://localhost:8888/api/#{type}/#{Rails.env}#{path}")
      response = RestClient.send(method, URI.encode("#{Rails.application.jupyter_path}/api/#{type}/#{Rails.env}#{path}"))
    else
      # response = HTTP.send(method,"http://localhost:8888/api/#{type}/#{Rails.env}#{path}", :json => payload)
      response = RestClient.send(method, URI.encode("#{Rails.application.jupyter_path}/api/#{type}/#{Rails.env}#{path}"), payload.to_json)
    end
    res = JSON.parse(response.body)
    temp = res["path"].split "/"
    temp[0] = nil
    res["path_without_env"] = temp.join("/")
    return res
  end

  def Project.mk_request(method,request)
    response = HTTP.send(method,request)
    return response
  end

  def nbpath
    user = User.find self.user_id
    home = user.home_path
    return "#{Rails.env}#{home}/#{self.id}/index.ipynb"
  end

  private
    def replace_last path, name
      temp = path.split("/")
      temp[temp.length-1] = name
      temp.join("/")
    end 

end
