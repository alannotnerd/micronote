class Project < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true

  def create_home
    # todo create project home  
    home = user.home_path
  end

  def Project.api(method, type, path, payload={})
    token = Rails.application.get_token
    if payload.empty?
      response = HTTP.cookies(token).send(method,"http://localhost:8888/api/#{type}/#{Rails.env}#{path}")
    else
      response = HTTP.cookies(token).send(method,"http://localhost:8888/api/#{type}/#{Rails.env}#{path}", :json => payload)
    end
    return JSON.parse(response.body)
  end
end
