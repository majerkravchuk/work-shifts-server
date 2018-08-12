require 'mina/rails'
require 'mina/puma'
require 'mina/git'
require 'mina/rvm'

require 'dotenv/load'
Dotenv.load

set :application_name, 'work-shifts-server'
set :deploy_to, '/home/deploy/work-shifts/server'
set :repository, 'git@github.com:BabenkoOleg/work-shifts-server.git'
set :branch, 'master'

set :domain, ENV['SERVER_HOST']
set :user,   ENV['SERVER_USER']
set :port,   ENV['SERVER_PORT']
set :forward_agent, true

set :rvm_use_path, '/usr/share/rvm/scripts/rvm'

set :shared_dirs, fetch(:shared_dirs, []).push('public/assets', 'log', 'tmp/pids', 'tmp/sockets', 'storage')
set :shared_files, fetch(:shared_files, []).push('config/puma.rb', 'config/master.key','.env')

# This task is the environment that is loaded for all remote run commands, such as
# `mina deploy` or `mina rake`.
task :remote_environment do
  # For those using RVM, use this to load an RVM version@gemset.
  invoke :'rvm:use', 'ruby-2.5.1@default'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  # command %{rbenv install 2.3.0 --skip-existing}
end

desc 'Deploys the current version to the server.'
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    command %{yarn install}
    invoke :'rails:assets_precompile'
    command %{RAILS_ENV=production bundle exec rails trumbowyg:nondigest}
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end

      invoke :'puma:restart'
      invoke :'server:wait_puma'
    end
  end
end

namespace :server do
  task start: :remote_environment do
    invoke :'puma:start'
    invoke :'server:wait_puma'
  end

  task stop: :remote_environment do
    invoke :'puma:stop'
  end

  task wait_puma: :remote_environment do
    command %[
      until [ -e #{fetch(:pumactl_socket)} ]; do
        echo "Wait puma..." && sleep 1
      done
    ]
  end
end

namespace :client do
  task deploy: :remote_environment do
    command %[
      cd /home/deploy/work-shifts/client && git pull && yarn && yarn build
    ]
  end
end
