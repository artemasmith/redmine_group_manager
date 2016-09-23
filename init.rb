#!/bin/env ruby
# encoding: utf-8
Redmine::Plugin.register :groupmanager do
  name 'Redmine Group manager plugin'
  author 'Artem Kuznetsov'
  description 'This plugin provide groups management tab for project allowing non redmine-admins users to manage groups'
  version '0.2.0'
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
    permission :change_owner, :gmanagers => [:update_admin]

  end
  menu :project_menu, :groups, {:controller => 'gmanagers', :action => 'index'}, :caption=> "Groups",:last=>true, :param => :project_id
end
