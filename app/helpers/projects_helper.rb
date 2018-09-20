module ProjectsHelper
  def view_for(project)
    return "#{Rails.application.jupyter_path}/nbconvert/html/#{project.nbpath}?download=false"
  end

  def edit_url(project)
    return "#{Rails.application.jupyter_path}/notebooks/#{@project.nbpath}"
  end
end
