# config valid only for current version of Capistrano
lock '3.16.0'

# Capistranoのログの表示に利用する
set :application, 'speadwear'
set :deploy_to, '/var/www/speadwear'

# どのリポジトリからアプリをpullするかを指定する
set :repo_url,  'git@github.com:House-lovers7/speadwear.git'

# バージョンが変わっても共通で参照するディレクトリを指定
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'public/uploads')

set :rbenv_type, :user
set :rbenv_ruby, '2.7.2' 

# どの公開鍵を利用してデプロイするか

set :ssh_options, { 
  auth_methods: ['publickey'],
  user: "ec2-user",
  # keys: ['~/.ssh/speadwear-keypair.pem'] 
  keys: %w(/home/runner/.ssh/github),
  forward_agent: false, 
  # port: 10024    
}             

# プロセス番号を記載したファイルの場所
set :unicorn_pid, -> { "#{shared_path}/tmp/pids/unicorn.pid" }

# Unicornの設定ファイルの場所
set :unicorn_config_path, -> { "#{current_path}/config/unicorn.rb" }
set :keep_releases, 5

set :default_env, {
  aws_access_key_id: ENV['S3_ACCESS_KEY_ID'],
  aws_secret_access_key: ENV['S3_SECRET_ACCESS_KEY'],
  region: ENV['S3_REGION']
}

set :rbenv_path, '/home/ec2-user/.rbenv/'

# デプロイ処理が終わった後、Unicornを再起動するための記述
after 'deploy:publishing', 'deploy:restart'
namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
