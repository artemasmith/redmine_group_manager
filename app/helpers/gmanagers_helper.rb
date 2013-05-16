module GmanagersHelper

def link_to_group(id)
    name=Gmanager.get_group_name_by_id(id)
    return link_to name, gmanager_path(id,:project_id=>params[:project_id])
end

def render_group_by_id(id)
    return Gmanager.get_group_name_by_id(id)
end

def render_user_depart(id)
    return Gmanager.get_user_depart(id)
end

def render_custom_fields()
    return Gmanager.get_user_custom_fields()
end

end
