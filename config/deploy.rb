# -*- coding: utf-8 -*-
# lock '3.5.0'

set :application, 'miro'
set :repo_url, 'git@github.com:HakubJozak/miro.git'
set :ssh_options, forward_agent: true
set :deploy_to, -> {  "/home/#{fetch(:application)}/#{fetch(:stage)}" }
set :branch, 'master'

set :linked_dirs,  %w{log public/system tmp}
# FIXME: uncomment for Thinking Sphinx
# set :linked_dirs,  %w{log public/system tmp db/sphinx}
set :linked_files, %w{ .env }

set :sidekiq_role, :worker

set :puma_threads, [0, 8]
set :puma_workers, 0
set :whenever_roles, -> { :cron }

set :rvm_roles, [ :app, :worker ]
set :rvm_type, :user
set :rvm_ruby_version, '2.2.2'
set :puma_default_hooks, false


before 'deploy:publishing', 'puma:create_dirs'
after 'deploy:publishing', 'puma:phased-restart'
# after 'deploy:publishing', 'monit:monitor'

# FIXME: uncomment for Thinking Sphinx
# before 'deploy:publishing', "thinking_sphinx:stop"
# after "deploy:publishing", "thinking_sphinx:configure"
# after "deploy:publishing", "thinking_sphinx:start"

set :puma_default_hooks, false

before 'deploy:publishing', 'puma:create_dirs'
after 'deploy:finished', 'serviceman:puma:restart'


