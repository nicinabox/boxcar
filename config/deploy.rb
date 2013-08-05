require 'bundler/capistrano'

set :application, "boxcar"
set :repository,  "git@github.com:nicinabox/boxcar.git"
set :port, 9095
set :deploy_to, "/usr/apps/#{application}"
set :deploy_via, :remote_cache
set :user, "root"
set :use_sudo, false

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "98.226.202.159"                          # Your HTTP server, Apache/etc
role :app, "98.226.202.159"                          # This may be the same as your `Web` server
role :db,  "98.226.202.159", :primary => true # This is where Rails migrations will run

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"
