class Project < ActiveRecord::Base
  belongs_to :user
  before_save :unique?
  after_create :create_home
  after_destroy :rm_home
  validates :user_id, presence: true

  def create_home
    user = User.find user_id 
    home = user.home_path
    @absolute_path = "#{home}/#{id}"
    Datafolder::Env.createDir(id.to_s, user.id.to_s)
    Datafolder::Env.createNote "/#{user.id}/#{id}"
    Datafolder::Env.createDir "asset", "#{user.id}/#{id}"
  end

  def rm_home
    # user = User.find user_id
    # home = user.home_path
    # Project.api "delete", "contents", home+name 
    Datafolder::Env.del_r home
  rescue 
    puts "#{id} Not Fount"
  end

  def self.clean
    all = Project.all
    all.each do |p|
      _ps = Project.where(user_id: p.id, name: p.name)
      _p_main = _ps[0]
      _ps.each do |_p|
        _p.destroy unless _p.id == _p_main.id
      end
    end
  end

  def self.import(p_id, u_id, c_id)
    project = Project.find(p_id)
    false unless Project.find_by(name: project.name, user_id: u_id, pushed_by: c_id).nil?

    newprj = Project.create name:project.name, user_id:u_id, pushed_by: c_id
    Datafolder::Env.mv_r "#{project.user_id}/#{p_id}/asset", "#{u_id}/#{newprj.id}"
    Datafolder::Env.mv_r "#{project.user_id}/#{p_id}/index.ipynb", "#{u_id}/#{newprj.id}"
    true
  end

  def isOpen?
    if pushed_by.nil?
      true
    else
      course = Course.find pushed_by
      course.opened
    end
  end

  def nbpath
    user = User.find user_id
    home = user.home_path
    return "#{Rails.env}#{home}/#{id}/index.ipynb"
  end

  def home
    user = User.find user_id
    home = user.home_path
    return "#{Rails.env}#{home}/#{id}"
  end

  private

  def unique?
    !pushed_by.nil? || Project.find_by(name: name, user_id: user_id).nil?
  end

  def replace_last(path, name)
    temp = path.split('/')
    temp[temp.length-1] = name
    temp.join('/')
  end


end
