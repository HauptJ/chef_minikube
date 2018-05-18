#
# Cookbook:: minikube
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

# Windows is not currently supported

command_name = 'minikube'
platform = 'linux'
arch = 'amd64'
do_install = true
version = node['minikube']['version'] != 'latest' ? "v#{node['minikube']['version']}" : 'latest'


# Check to see if minikube is already installed, and if the version matches.
cmd = "#{node['minikube']['install_prefix']}#{File::SEPARATOR}#{command_name}"

if File.exist?(cmd)
	log "#{cmd} exists, looking for version: #{version}" do
		level :info
	end

	stdout, status = Open3.capture2(cmd, 'version')
	raise "Failed to execute '#{cmd} version'" unless status.success?

	log "reported version: #{stdout.strip}" do
		level :info
	end

	if stdout.strip == "minikube version: #{version}"
		do_install = false
	end
end

if do_install
	log "installing minikube to #{node['minikube']['install_prefix']}" do
		level :info
	end

	directory node['minikube']['install_prefix'] do
		mode '0755'
		recursive
	end

	remote_file '/usr/local/bin/kubectl' do
	  source node['minikube']['kubectl_download_url']
	  mode '0755'
	  backup false
	end

	remote_file '/usr/local/bin/minikube' do
  	source node['minikube']['minikube_download_url']
  	mode '0755'
  	backup false
	end

end
