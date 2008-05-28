# require "railsmachine/recipes"
# require 'vendor/plugins/acts_as_ferret/lib/ferret_cap_tasks'

set :application, "cooking_compendium"
set :repository,  "https://svn.cookingcompendium.com/cookbook/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, "subversion"
role :app, "www.cookingcompendium.com"
role :web, "www.cookingcompendium.com"
role :db,  "www.cookingcompendium.com", :primary => true

set :user, 'deploy'
set :mongrel_conf, "#{current_path}/config/mongrel_cluster.yml"

set :start_mongrel,   "/etc/init.d/mongrel_cluster start"
set :stop_mongrel,    "/etc/init.d/mongrel_cluster stop"
set :restart_mongrel, "/etc/init.d/mongrel_cluster restart"

namespace :deploy do

  desc "after update code"
  task :after_update_code do
    run "cp #{shared_path}/database.yml #{release_path}/config"
    run "ln -s #{shared_path}/photos #{release_path}/public/photos"
  end

  desc "Restart mongrel"
  task :restart, :roles => :app do
    sudo restart_mongrel
  end

  desc "Start mongrel"
  task :start, :roles => :app do
    sudo start_mongrel
  end

  desc "Stop Mongrel"
    sudo stop_mongrel
  task :stop, :roles => :app do
  end

end
