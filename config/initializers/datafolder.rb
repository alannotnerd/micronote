module Datafolder
  class Env

    def Env.createDir(name, base_dir)
      Env.create(name, base_dir, "directory")
      return nil
    end

    def Env.createNote(base_dir)
      Env.create("index.ipynb", base_dir, "notebook")
      return nil
    end

    def Env.del(path)
      path[0] = "" if path.start_with? '/'
      path[-1] = "" if path.start_with? '/'
      if path.empty?
        RestClient.delete(URI.encode("#{Rails.application.jupyter_path}/api/contents/#{Rails.env}"))
      else
        RestClient.delete(URI.encode("#{Rails.application.jupyter_path}/api/contents/#{Rails.env}/#{path}"))
      end
      return nil
    end

    def Env.del_r(path)
      subdir = Env.ls path
      if subdir.empty?
        Env.del path
      else
        subdir.each do |content|
          subpath = content["path"].split("/").map {|i| i.to_s}
          subpath.shift
          subpath = subpath.join "/"
          if content["type"] == "directory" 
            Env.del_r subpath
          else
            Env.del subpath
          end
        end
        Env.del path
      end
    end

    def Env.exist?(path)
      begin
        if path.empty?
          RestClient.get(URI.encode("#{Rails.application.jupyter_path}/api/contents/#{Rails.env}"))
        else
          RestClient.get(URI.encode("#{Rails.application.jupyter_path}/api/contents/#{Rails.env}/#{path}"))
        end
      rescue => a
        false
      else
        true
      end
    end

    def Env.init
      unless Env.exist? ""
        RestClient.put(
          URI.encode("#{Rails.application.jupyter_path}/api/contents/#{Rails.env}"),
          {name: Rails.env, path: Rails.env, content: "", type: "directory"}.to_json
        )
      end
    end

    def Env.ls(path)
      response = RestClient.get(URI.encode("#{Rails.application.jupyter_path}/api/contents/#{Rails.env}/#{path}"))
      response = JSON.parse(response.body)
      return response["content"]
    end      

    def Env.drop
      Env.del_r "/"
    end

    private
      def Env.create(name , base_dir, type)
        # assert path in ["directory", "notebook"]
        base_dir[0] = '' if base_dir.start_with? "/"
        base_dir[-1] = '' if base_dir.end_with? "/"
        if base_dir.empty?
          path = name
        else
          path = "#{base_dir}/#{name}"
        end
        if type == "directory"
          RestClient.put(URI.encode("#{Rails.application.jupyter_path}/api/contents/#{Rails.env}/#{path}"), {name: name, path: "/"+path, content: "", type: type}.to_json)
        elsif type == "notebook"
          sample = JSON.parse('{"type":"notebook","content":{"cells":[{"metadata":{},"cell_type":"markdown","source":"# Sample\nThis is sample markdown cell"}],"metadata":{"kernelspec":{"name":"python3","display_name":"Python 3","language":"python"},"language_info":{"name":"python","version":"3.6.5","mimetype":"text/x-python","codemirror_mode":{"name":"ipython","version":3},"pygments_lexer":"ipython3","nbconvert_exporter":"python","file_extension":".py"}},"nbformat":4,"nbformat_minor":2}}')
          RestClient.put(URI.encode("#{Rails.application.jupyter_path}/api/contents/#{Rails.env}/#{path}"), {name: name, path: "/"+path, content: sample["content"], type: type}.to_json)
        else
          raise "no such type"
        end
        return nil
      end
      def Env.replace_last path, name
        temp = path.split("/")
        temp[temp.length-1] = name
        temp.join("/")
      end 
  end
end

Datafolder::Env.init
