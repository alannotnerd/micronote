module ProjectsHelper
  def view_for(project)
    return "#{Rails.application.jupyter_path}/nbconvert/html/#{project.nbpath}?download=false"
  end

  def cells(project)
    res = Project.api "get", "contents", "/#{project.user_id}/#{project.id}/index.ipynb"
    Cell.arr res["content"]["cells"]
  end

  def edit_url(project)
    return "#{Rails.application.jupyter_path}/notebooks/#{@project.nbpath}"
  end
end
