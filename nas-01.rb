# # data drive
# UUID=bc680280-dd0b-4d26-b88a-84a578aa48bc /mnt/data       ext4    defaults        0       0

# cookbook 'samba', '~> 1.2.0'

# execute 'apt-get-update' do
#   command 'apt-get update'
# end

# apt_package 'samba'
# apt_package 'smbfs'

# include_recipe 'samba::server'
# include_recipe 'samba::share'
# include_recipe 'samba::user'

directory '/mnt/data-2' do
  action :create
  owner 'garethd'
  group 'garethd'
  mode '0755'
end

mount '/mnt/data-2' do
  device '34451D606552997A'
  device_type :uuid
  fstype 'ntfs'
  options 'defaults'
  action [:mount, :enable]
end

execute 'apt-get-update' do
  command 'apt-get update'
end

apt_package 'openssh-server'

samba_user 'user1' do
  password 'user1' # user password for samba and the system
  # comment 'user_name_comment'
  home '/mnt/data-2' # Users home.
  shell '/bin/zsh' # User shell to set, e.g. /bin/sh, /sbin/nologin
  manage_home true # true/false, whether to manage the users home directory location
end

samba_server 'samba server' do
  hosts_allow '192.168.1.0/24'
end

samba_share 'data-2' do
  comment
  guest_ok 'yes'
  write_list 'user1'
  valid_users 'user1'
  path '/mnt/data-2'
end