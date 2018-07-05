module Datafolder
  class Env
    def Env.root_path()
      if Rails.env.development?
        path = '/data/rails/development'
        FileUtils.mkdir_p(path) unless Dir.exist?(path)
      elsif Rails.env.test?
        path = '/data/rails/test'
        FileUtils.mkdir_p(path) unless Dir.exist?(path)
      else
        path = '/data/rails/production'
        FileUtils.mkdir_p(path) unless Dir.exist?(path)
      end
      return path
    end
  end
end
