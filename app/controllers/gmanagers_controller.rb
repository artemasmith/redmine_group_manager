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
    #only one group not all of them
    @groups = Gmanager.all(params[:project_id])
    @temp="hello"
  end
  
  def edit
    @project = Project.find(params[:project_id])
    @group=Gmanager.get_group_users(params["id"])
  end

  def update
  end

  def destroy
  end
end
