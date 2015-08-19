directory '/mnt/data' do
  action :create
  owner 'garethd'
  group 'garethd'
  mode '0755'
end


mount '/mnt/data' do
  device 'bc680280-dd0b-4d26-b88a-84a578aa48bc'
  device_type :uuid
  fstype 'ext4'
  options 'defaults'
  action [:mount, :enable]
end

execute 'apt-get install software properties common' do
  command 'apt-get install software-properties-common'
end

execute 'add-repo' do
  command 'add-apt-repository -y ppa:team-xbmc/ppa'
end

execute 'apt-get-update' do
  command 'apt-get update'
end

apt_package 'kodi'            
