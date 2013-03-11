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


def self.delete_user_from_group(idus,idgr)
    gr=Group.find(idgr)
    us=User.find(idus)
    gr.users.delete(us)
    gr.save
end

end
