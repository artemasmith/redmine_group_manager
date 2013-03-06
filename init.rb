Redmine::Plugin.register :groupmanager do
  name 'Groupmanager plugin'
  author 'Artem Kuznetsov'
  description 'This plugin used for project tabs group management by project-admins. Non redmine admins'
  version '0.0.1'
  url 'https://github.com/artemasmith/redmine-groups-manager.git'
  author_url 'https://github.com/artemasmith'

  project_module :groups do
    permission :view_groups, :gmanagers => :index
    permission :create_groups, :gmanager => :new
    permission :change_existing_groups, :gmanagers => :update
    permission :delete_groups, :gmanager => :destroy
    permission :view_users_in_groups, :gmanager => :show
    permission :edit_groups, :gmanager => :edit
  end
  menu :project_menu, :groups, {:controller => 'gmanagers', :action => 'index'}, :caption=> "GroupsM",:last=>true, :param => :project_id
end
