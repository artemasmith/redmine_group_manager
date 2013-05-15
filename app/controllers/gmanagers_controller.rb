#!/bin/env ruby
# encoding: utf-8
class GmanagersController < ApplicationController
  unloadable

    before_filter :find_project, :authorize

    def find_project
	@project=Project.find(params["project_id"])
    end
    
  def index
	@project = Project.find(params[:project_id])
	@groups = Gmanager.all(params[:project_id])
  end
  
  def create
    @project = Project.find(params[:project_id])
    res = Gmanager.create_group(params["project_id"],params["groupname"],session['user_id'])
    
    error=''
    if res
	error="группа с таким именем уже существует"
    end
    respond_to do |format|
	format.html {redirect_to gmanagers_path(:project_id=>@project,:error=>error)}
    end
    
    
  end

    

  def new
    @project = Project.find(params[:project_id])
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
    @group = Group.find(params["id"])
    temp=params["edit"]
    
    if Gmanager.is_admin_group(params["id"]) and not Gmanager.may_user_do(@project,session["user_id"],:change_admin_groups)
	respond_to do |format|
	    format.html {render :action => "edit", :error => "У вас нет прав для редактирвоания этой группы"}
	end
    end

    case temp
	when "group_name"
	    res=Gmanager.update_name(params["id"],params["groupname"])
	    if res
		respond_to do |format|
		    format.html {redirect_to edit_gmanager_path(:project_id=>@project,:id=>params["id"])}
		end
	    else
		respond_to do |format|
		    format.html {render :action => "edit", :error=>"Группа с таким именем уже существует"}
		end
	    end
	when "add_user"
	    if params["user_select"]

		users = User.find_all_by_id(params["user_select"])
		@group.users << users
		respond_to do |format|
		    format.html {redirect_to edit_gmanager_path(:project_id=>@project,:id=>params["id"])}
		end
	    else
		respond_to do |format|
		    format.html {redirect_to edit_gmanager_path(:project_id=>@project,:id=>params["id"],:error=>"Группа с таким именем уже существует")}
		end

	    end
	when "del_user"
	    #@group.users.delete(User.find(params["user"]))
	    Gmanager.delete_user_from_group(params["user"],params["group"])
	    respond_to do |format|
		    format.html {redirect_to edit_gmanager_path(:project_id=>@project,:id=>params["group"])}
	    end
	
    end
  end
  
#empty controllers action
  def update_admin
    
  end
#empty controllers action
  def delete_admin
  
  end

  def destroy
    @project = Project.find(params[:project_id])
    Gmanager.delete_group(params["project_id"],params["id"])
    respond_to do |format|
	format.html {redirect_to gmanagers_path(:project_id=>@project)}
    end
  end
end
