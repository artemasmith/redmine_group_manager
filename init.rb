#!/bin/env ruby
# encoding: utf-8
Redmine::Plugin.register :groupmanager do
  name 'Groupmanager plugin'
  author 'Artem Kuznetsov'
  description 'This plugin used for project tabs group management by project-admins. Non redmine admins'
  version '0.1.5'
  url 'https://github.com/artemasmith/redmine-groups-manager.git'
  author_url 'https://github.com/artemasmith'

  project_module :groups do
    permission :view_groups, :gmanagers => [:index, :show]
    permission :create_groups, :gmanagers => [:new, :create]
    permission :change_groups, :gmanagers => [:update, :edit]
    permission :delete_groups, :gmanagers => [:destroy,:delete]
    permission :change_admin_groups, :gmanagers => [:update_admin]
    permission :delete_admin_groups, :gmanagers => [:delete_admin]
    permission :change_other_groups, :gmanagers => [:update_admin]
    permission :delete_other_groups, :gmanagers => [:delete_admin]

  end
  menu :project_menu, :groups, {:controller => 'gmanagers', :action => 'index'}, :caption=> "Группы",:last=>true, :param => :project_id
end
