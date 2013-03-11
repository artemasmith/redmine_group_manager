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
    @group = Gmanager.get_group_users(params["id"])
  end
  
  def edit
    @project = Project.find(params[:project_id])
    @group=Gmanager.get_group_users(params["id"])

    @all_users=Gmanager.get_all_project_users(params[:project_id],params["id"])
  end

  def update
    @project = Project.find(params[:project_id])
    @group=Group.find(params["id"])
    temp=params["edit"]
    

    case temp
	when "add_user"
	    if params["user_select"]

		users = User.find_all_by_id(params["user_select"])
		@group.users << users
		respond_to do |format|
		    format.html {redirect_to edit_gmanager_path(:project_id=>@project,:id=>params["id"])}
		end
	    else
		respond_to do |format|
		    format.html {render :action => "edit"}
		end

	    end
	when "del_user"
	    #@group.users.delete(User.find(params["user"]))
	    Gmanager.delete_user_from_group(params["user"],params["group"])
	    respond_to do |format|
		    format.html {redirect_to edit_gmanager_path(:project_id=>@project,:id=>params["group"])}
	    end
	when "group_name"
	    
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    
  end
end
