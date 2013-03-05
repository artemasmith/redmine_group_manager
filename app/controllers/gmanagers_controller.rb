class GmanagersController < ApplicationController
  unloadable


  def index
	@project = Project.find(params[:project_id])
	@groups = Gmanager.all(params[:project_id])
  end

  def new
  end

  def update
  end

  def delete
  end
end
