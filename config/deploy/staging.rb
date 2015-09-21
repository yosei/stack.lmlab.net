set :rails_env, 'production'
set :deploy_to, '/opt/dev.stack.lmlab.net'
server 'sakura15', user: fetch(:user), roles: %w{app db web}

