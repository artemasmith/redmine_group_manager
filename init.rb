Redmine::Plugin.register :groupmanager do
  name 'Groupmanager plugin'
  author 'Artem Kuznetsov'
  description 'This plugin used for project tabs group management by project-admins. Non redmine admins'
  version '0.0.1'
  url 'https://github.com/artemasmith/redmine-groups-manager.git'
  author_url 'https://github.com/artemasmith'

  project_module :groups do
    permission :view_groups, :gmanagers => [:index, :show]
    permission :create_groups, :gmanager => [:new, :create]
    permission :change_groups, :gmanagers => [:update, :edit]
    permission :delete_groups, :gmanager => :destroy

  end
  menu :project_menu, :groups, {:controller => 'gmanagers', :action => 'index'}, :caption=> "GroupsM",:last=>true, :param => :project_id
end
