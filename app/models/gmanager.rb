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
 
end
