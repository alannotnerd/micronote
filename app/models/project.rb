class Project < ActiveRecord::Base
  belongs_to :user
  after_create :create_home
  validates :user_id, presence: true

  def create_home
    user = User.find self.user_id 
    home = user.home_path
    @absolute_path = "#{home}/#{self.id}"

    # todo: user new api

    Datafolder::Env.createDir(self.id.to_s, user.id.to_s)
    Datafolder::Env.createNote "/#{user.id}/#{self.id}"
    Datafolder::Env.createDir "asset", "#{user.id}/#{self.id}"
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
