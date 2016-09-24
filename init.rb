#!/bin/env ruby
# encoding: utf-8
Redmine::Plugin.register :redmine_group_manager do
  name 'Redmine Group manager plugin'
  author 'Frederick Thomssen (originally by Artem Kuznetsov)'
  description 'This plugin provides a groups management tab for projects allowing non-admin users to manage groups'
  version '0.3.0'
  url 'https://github.com/fathomssen/redmine_group_manager.git'
  author_url 'https://github.com/fathomssen'

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
