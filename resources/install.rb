property :download_url, String,
         default: 'https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz',
         description: 'Download URL'
property :chruby_pgp_key_url, String,
         default: 'https://raw.github.com/postmodern/chruby/master/pkg/chruby-0.3.9.tar.gz.asc',
         description: 'PGP key download URL'
property :postmodern_pgp_key_url, String,
         default: 'https://raw.github.com/postmodern/postmodern.github.io/master/postmodern.asc',
         description: ''
property :chruby_version, String,
         default: '0.3.9',
         description: 'Chruby tar version'
property :user, String,
         default: 'root',
         description: 'Username to install chruby for. On MacOS change this to your local user'

action :install do
  chruby_pgp_key_path = ::File.join(Chef::Config[:file_cache_path], 'chruby.tar.gz.asc')
  tar_path = ::File.join(Chef::Config[:file_cache_path], 'chruby.tar.gz')
  postmodern_pgp_key_path = ::File.join(Chef::Config[:file_cache_path], 'postmodern.asc')

  package gpg_package
  package 'make'

  remote_file tar_path do
    source new_resource.download_url
    owner 'root'
    group 'root'
    mode '0755'
  end

  remote_file chruby_pgp_key_path do
    source new_resource.chruby_pgp_key_url
    owner 'root'
    group 'root'
    mode '0755'
  end

  remote_file postmodern_pgp_key_path do
    source new_resource.postmodern_pgp_key_url
    owner 'root'
    group 'root'
    mode '0755'
    notifies :run, 'execute[Import GPG Key]', :immediately
  end

  execute 'Import GPG Key' do
    command "gpg --import #{postmodern_pgp_key_path}"
    notifies :run, 'execute[verify tar]', :immediately
    action :nothing
  end

  execute 'verify tar' do
    command "gpg --verify #{chruby_pgp_key_path} #{tar_path}"
    notifies :run, 'execute[install chruby]', :immediately
    action :nothing
  end

  execute 'install chruby' do
    cwd Chef::Config[:file_cache_path]
    command <<-EOH
      tar -xzvf chruby.tar.gz
      cd chruby-#{new_resource.chruby_version}
      sudo make install
    EOH
    action :nothing
  end

  cookbook_file ::File.join(d_directory, 'chruby.sh') do
    source 'chruby.sh'
    cookbook 'chruby'
    notifies :write, 'log[macos_users]', :immediately if platform_family?('mac_os_x')
  end

  log 'macos_users' do
    message "Please add a script to load your #{d_directory} contents into your shell"
    level :info
    action :nothing
  end
end

action_class do
  include Chef::Chruby::Helpers
end
