server 'theshelf.groupbuddies.com', user: 'deploy', roles: %w{web app db}, primary: true

set :application, 'theshelf'
set :stage, :production
set :rails_env, :production
set :branch, :master
set :deploy_to, '/home/deploy/theshelf'
