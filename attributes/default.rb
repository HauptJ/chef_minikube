default['minikube']['download_base_url'] = 'https://storage.googleapis.com/minikube/releases'
default['minikube']['version'] = 'latest'

default['minikube']['install_prefix'] = if node['platform_family'] == 'windows'
																					C:\Program Files'
																				else
																					default['minikube']['install_prefix'] = '/usr/local/bin'
																				end
