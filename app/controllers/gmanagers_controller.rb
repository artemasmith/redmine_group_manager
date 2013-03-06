class GmanagersController < ApplicationController
  unloadable


  def index
	@project = Project.find(params[:project_id])
	@groups = Gmanager.all(params[:project_id])
  end

  def new
  end
  
  def show
    @project = Project.find(params[:project_id])
    @groups = Gmanager.all(params[:project_id])
    @temp="hello"
  end
  

  def update
  end

  def destroy
  end
end
