# # data drive
# UUID=bc680280-dd0b-4d26-b88a-84a578aa48bc /mnt/data       ext4    defaults        0       0

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

apt_package 'transmission'

apt_package 'openssh-server'

# see: http://stackoverflow.com/questions/9898614/what-is-the-idiomatic-way-to-install-a-debian-package-using-chef

remote_file "/tmp/google-chrome-stable_current_amd64.deb" do
  source "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
  mode 0644
end

dpkg_package "google-chrome" do
  source "/tmp/google-chrome-stable_current_amd64.deb"
  action :install
end
