server '52.63.11.71', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/yukofu/.ssh/id_rsa'