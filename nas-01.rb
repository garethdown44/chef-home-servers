# # data drive
# UUID=bc680280-dd0b-4d26-b88a-84a578aa48bc /mnt/data       ext4    defaults        0       0

directory '/mnt/data-2' do
  action :create
  owner 'garethd'
  group 'garethd'
  mode '0755'
end

mount '/mnt/data-2' do
  device 'TODO'
  device_type :uuid
  fstype 'ntfs'
  options 'defaults'
  action [:mount, :enable]
end

execute 'apt-get-update' do
  command 'apt-get update'
end

apt_package 'openssh-server'