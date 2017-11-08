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

set :puma_threads, [0, 8]
set :puma_workers, 0


set :rvm_roles, [ :app, :worker ]
set :rvm_type, :user
set :rvm_ruby_version, '2.4.1'
set :puma_default_hooks, false


# before 'deploy:publishing', 'puma:create_dirs'
# after 'deploy:publishing', 'puma:phased-restart'
after 'deploy:finished', 'serviceman:puma:restart'
# after 'deploy:publishing', 'monit:monitor'

# FIXME: uncomment for Thinking Sphinx
# before 'deploy:publishing', "thinking_sphinx:stop"
# after "deploy:publishing", "thinking_sphinx:configure"
# after "deploy:publishing", "thinking_sphinx:start"


task :a_friend_of_mine_is_a_friend_of_yours do
  # transfer what *I* know about github to the host
  github_known_hosts_line = `cat ~/.ssh/known_hosts | grep github.com`
  on roles(:app) do
    execute "echo #{github_known_hosts_line} >> ~/.ssh/known_hosts"
  end
end


