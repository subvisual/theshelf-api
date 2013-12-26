server 'localhost', user: 'deploy', roles: %w{web app db}, primary: true

set :application, 'theshelf-staging'
set :stage, :staging
set :rails_env, :staging
set :branch, :dev
set :deploy_to, '/var/www/theshelf-staging'

# vagrant specific options
set :default_shell, 'bash -l'
set :ssh_options, { port: 2222, forward_agent: true }
