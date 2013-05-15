class Gmanager < ActiveRecord::Base
  unloadable
  
  
#show all project groups
def self.all(pr_id)

    pr_id=pr_id.to_s
    pid=Project.find_by_identifier(pr_id).id
    
    mem=Member.find_all_by_project_id(pid)
    res={}
    for m in mem
	begin
	    gr=Group.find(m.user_id)
	    users=User.in_group(m.user_id)
	    res[m.user_id]=users
	    
	rescue
	    #if not group go next by loop
	    next
	end
	
    end
    return res
end
  
  
def self.get_group_name_by_id(id)
    return Group.find(id).lastname
end

#return users's department from custom values
def self.get_user_depart(id)
    val=User.find(id).custom_values
    res={}
    res[:pos]=val[0][:value].to_s 
    res[:dep]= val[1][:value].to_s
    return res
end

def self.get_group_users(id)
    id=id.to_s
    return User.in_group(id)
end

#get all users exept group's
def self.get_all_project_users(id,grid)
    id=id.to_s
    pid=Project.find_by_identifier(id).id
    tres=[]
    mem=Member.find_all_by_project_id(pid)
    mem.delete_if{|x| x.user_id==grid}
#   gusers=User.in_group(grid) 
    mcount=mem.count
    for i in 0..mcount-1
# WTF???
#	if !gusers.index{|x| x["id"].to_i==mem[i]['user_id'].to_i}
	    begin
		user=User.find(mem[i]['user_id'])
		tres.push(user)
	    rescue
		tres.concat(User.in_group(mem[i]['user_id']))
		tres.uniq!
	    end

	end
#    end
    
#Fucking dump piecae of code cose index not working    

    gusers=User.in_group(grid)
    temp=[]
    for i in gusers
	temp.push(i["id"])
    end
    res={}
    for t in tres
	if !temp.index(t["id"])
	    res[t["id"]]=t["lastname"].to_s + " " + t["firstname"].to_s
	end
    end
    return res
    
end

def self.update_name(idgr,name)
    begin
	gr=Group.find(idgr)
	res=gr.update_attributes(:lastname=>name.to_s)
	return res
    rescue
	return 0
    end
end

def self.delete_user_from_group(idus,idgr)
    gr=Group.find(idgr)
    us=User.find(idus)
    gr.users.delete(us)
    gr.save
end

#MAKE check what are you send to db
#idpr - identifier of project (letter)
#name - name of group
#owner - id of user, who create group
def self.create_group(idpr,name,owner)
    #check the unique of name
    if Group.find_by_lastname(name).blank?
    
    gr=Group.create(:lastname=>name)
    pid=Project.find_by_identifier(idpr).id
    mem=Member.new(:project_id=>pid,:user_id=>gr.id)
    mem.role_ids=[6]
    mem.save
    Project.find(pid).members << mem
    #create entry in gmanagers table
    gm=Gmanager.create(:id_group => gr.id, :id_owner => owner)
    gm.save
    
	return true
    else
	return true
    end
end

#idpr - identifier of project
#idgr - ID of deleted group
#iduser - Id of user who wants to delete group
def self.delete_group(idpr,idgr)

    pgm = Gmanager.find_by_id_group(idgr)
        
    pid=Project.find_by_identifier(idpr.to_s).id
    
    idm=Member.find_by_project_id_and_user_id(pid,idgr)
    Member.delete(idm)
    Group.delete(idgr)
    
    if pgm.blank?
	Gmanager.delete(pgm)
    end
end

#check if user have enough rights to do action to group
#return bool
#id_project-identifier of project (not ID)..
#id_user- ID user
#action -  desired action (symbol!)
def self.may_user_do(id_project,id_user,action)
    project=Project.find_by_identifier(id_project)
    user=User.find(id_user)
    roles=user.roles_for_project(project)
    for r in roles
	if r[:permissons].include?(action)
	    return true
	end
    end
    return false
end

#search in Gmanager, if there is no entry - group is admin group
def self.is_admin_group(idgr)
    if Gmanager.find_by_id_group(idgr).blank?
	return true
    else
	return false
    end
    
end

end
