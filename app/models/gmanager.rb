class Gmanager < ActiveRecord::Base
  unloadable
  
  
#show all project groups
def self.all(pr_id)

    #pr_id=Project.find_by_identifier(pr_id).id
    
    mem=Member.find_all_by_project_id(pr_id)
    res={}
    for m in mem
	users=User.in_group(m.user_id)
	gname=""
	until users.blank?
	    gname=Group.find(m.user_id).lastname
	    res[gname]=users
	end
	
    end
    return res
end
  
end
