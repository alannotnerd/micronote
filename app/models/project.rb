class Project < ActiveRecord::Base
  belongs_to :user
  after_create :create_home
  after_destroy :rm_home
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
    # user = User.find self.user_id
    # home = user.home_path
    # Project.api "delete", "contents", home+self.name
    begin
      Datafolder::Env.del_r self.home
    rescue 
      puts "#{self.id} Not Fount"
    end
  end

  def close
    update_attribute(:opened, false)
  end

  def Project.clean
    all = Project.all
    all.each do |p|
      _ps = Project.where(user_id: p.id, name: p.name)
      _p_main = _ps[0]
      _ps.each do |_p|
        _p.destroy unless _p.id == _p_main.id
      end
    end
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

  def Project.import p_id, u_id, c_id
    _project = Project.find(p_id)
    if c_id.nil?
      newprj = Project.create name:_project.name, user_id:u_id
    else
      newprj = Project.create name:_project.name, user_id:u_id, pushed_by: c_id
    end
    Datafolder::Env.mv_r "#{_project.user_id}/#{p_id}/asset", "#{u_id}/#{newprj.id}"
    Datafolder::Env.mv_r "#{_project.user_id}/#{p_id}/index.ipynb", "#{u_id}/#{newprj.id}"
  end

  def isOpen?
    return self.opened
  end

  def nbpath
    user = User.find self.user_id
    home = user.home_path
    return "#{Rails.env}#{home}/#{self.id}/index.ipynb"
  end
  def home
    user = User.find self.user_id
    home = user.home_path
    return "#{Rails.env}#{home}/#{self.id}"
  end

  private
    def replace_last path, name
      temp = path.split("/")
      temp[temp.length-1] = name
      temp.join("/")
    end 


end
