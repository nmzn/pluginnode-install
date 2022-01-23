##OneClick Install Script for plugin nodes via Docker.

echo -e "\n\n## Plugin Docker Install -- https://goplugin.co -- made by nmzn (Twitter @itsnmzn) 01/2022\n"
echo -e "\n\n## Please make sure to read the readme.md after installing!!!"
echo -e "## Version 1.0                                                                 \n\n"
echo -e "\n\n################# Updating System #################\n\n"
echo -e "\n\n################# Updating System #################\n\n"

sudo apt update && sudo apt upgrade

echo -e "\n\n################# Changing Directory #################\n\n"

sudo mkdir -p /opt/docker/goplugin
cd /opt/docker/goplugin

echo -e "\n\n################# getting plugin github Repository #################\n\n"

git clone -b docker_branch_v1 https://github.com/GoPlugin/plugin-deployment.git && cd plugin-deployment

echo -e "\n\n################# getting nmzn´s docker-compose github Repository #################\n\n"

git clone https://github.com/nmzn/pluginnode-docker.git
