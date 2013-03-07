class Gmanager < ActiveRecord::Base
  unloadable
  
  
#show all project groups
def self.all(pr_id)

    pr_id=pr_id.to_s
    pid=Project.find_by_identifier(pr_id).id
    
    mem=Member.find_all_by_project_id(pid)
    res={}
    for m in mem
	users=User.in_group(m.user_id)
	if !users.blank?
	    res[m.user_id]=users
	end
	
    end
    return res
end
  
  
def self.get_group_name_by_id(id)
    return Group.find(id).lastname
end

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

def self.get_all_project_users(id)
    id=id.to_s
    pid=Project.find_by_identifier(id).id
    tres=[]
    mem=Member.find_all_by_project_id(pid)
    for m in mem
	begin
	    user=User.find(m.user_id)
	    tres.push(user)
	rescue
	    tres.concat(User.in_group(m.user_id))
	    tres.uniq!
	end
    end
    res={}
    for t in tres
	res[t["id"]]=t["lastname"].to_s + " " + t["firstname"].to_s
    end
    return res
    
end


end
