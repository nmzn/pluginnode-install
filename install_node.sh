##Install Script for plugin nodes via Docker.
cd
echo -e "\n\n## Plugin Docker Install -- https://goplugin.co -- made by nmzn (Twitter @itsnmzn) 01/2022\n"
echo -e "\n\n## Please make sure to read the readme.md after installing!!!"
echo -e "## Version 0.1 \n\n"
echo -e "\n\n################# Updating System #################\n\n"

sudo apt update && sudo apt upgrade -y

echo -e "\n\n################# Changing Directory #################\n\n"

sudo mkdir -p /opt/docker/goplugin
cd /opt/docker/goplugin

echo -e "\n\n################# getting git repositories #################\n\n"

sudo git clone -b docker_branch_v1 https://github.com/GoPlugin/plugin-deployment.git && cd plugin-deployment/
sudo git clone https://github.com/nmzn/pluginnode-docker.git && cd pluginnode-docker && sudo cp docker-compose.yaml /opt/docker/goplugin/plugin-deployment && cd ..

echo -e "\n\n################# installing latest docker compose #################\n\n"

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo -e "\n\n################# Changing Credentials #################\n\n"

echo -e "Node Login"
echo
echo -e "Please insert your Credentials for your Node Login Password must be 8-50 characters!\n"
  read -p "Mailadress: " mail
echo
  read -s -p "Password: " password
echo
  read -s -p "Confirm: " password2
echo

while [ "$password" != "$password2" ];
do
    echo
    echo "Passwords dont match. Please try again!\n"
    echo
    read -s -p "Password: " password
    echo
    read -s -p "Confirm: " password2
    echo
done

echo
echo -e "Postgres Database Password"
echo
echo -e "Please type your Postgres Password.\n"
  read -s -p "Password: " pst
echo
  read -s -p "Confirm: " pst2
echo
echo

while [ "$pst" != "$pst2" ];
do
    echo
    echo "Passwords dont match. Please try again!\n"
    echo
    read -s -p "Password: " pst
    echo
    read -s -p "Confirm: " pst2
    echo
done

echo -e "Keystore Password"
echo
echo -e "Please enter a Keystore Password now!\n"
echo
echo -e "  *** KEYSTORE PASSWORD SHOULD FOLLOW THIS CONDITIONS ***"
echo -e "   must be longer than 12 characters"
echo -e "   must contain at least 3 lowercase characters"
echo -e "   must contain at least 3 uppercase characters"
echo -e "   must contain at least 3 numbers"
echo -e "   must contain at least 3 symbols"
echo -e "   must not contain more than 3 identical consecutive characters"
echo
read -s -p "Keystore Password: " kst
echo
read -s -p "Confirm Keystore: " kst2
echo

while [ "$kst" != "$kst2" ];
do
    echo
    echo "Keystore Password doesnt match. Please try again!"
    echo
    read -s -p "Password: " kst
    echo
    read -s -p "Confirm: " kst2
    echo
done

echo -e "\nSetting Postgres Password"

sudo sed -i "s/plugin1234/$pst2/g"  plugin.env ei.env
sudo sed -i "s/plugin1234/$pst2/g"  docker-compose.yaml
sudo sed -i "s/\postgres\b/dbuser/g" plugin.env
sudo sed -i "s/\postgres\b/dbuser/g" ei.env
sudo sed -i "s|"172.17.0.1"|psql_node|g" plugin.env
sudo sed -i "s|"172.17.0.1"|psql_ei|g" ei.env

echo
echo -e "Done..."

echo -e "\nSetting api Credentials"

sudo sed -i d .env.apicred
sudo sh -c 'echo "mail@mail.com" > .env.apicred'
sudo sh -c 'echo "mailpw" >> .env.apicred'
sudo sed -i "s/mail\@mail.com/$mail/g" .env.apicred
sudo sed -i "s/mailpw/$password2/g" .env.apicred
echo
echo -e "Done..."

echo -e "\nSetting Keystore Password"

sudo sed -i d .env.password
sudo sh -c 'echo "keystore" > .env.password'
sudo sed -i "s/keystore/$kst2/g" .env.password
echo
echo -e "Done..."

echo -e "\n\n################# Bringing up node & database #################\n\n"

sudo docker-compose up -d

echo -e "\n\n################# Starting Node #################\n\n"

sudo docker exec -it plinode /bin/bash -c ". ~/.profile && pm2 start /pluginAdm/startNode.sh"
echo
echo -e "Waiting for Node to come up... (10 Seconds)"
sleep 10
echo
echo -e "\n\n################# Installing External Initiators #################\n\n"

sudo docker exec -it plinode /bin/bash -c ". ~/.profile && plugin admin login -f /pluginAdm/.env.apicred"

JOBKEYS=$(sudo docker exec -it plinode /bin/bash -c ". ~/.profile && plugin initiators create pluginei http://localhost:8080/jobs" | grep pluginei)
sudo sh -c "echo $JOBKEYS > eivar.env"

ICACCESSKEY=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $4};')ca
ICSECRET=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $5};')
CIACCESSKEY=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $6};')
CISECRET=$(echo $JOBKEYS | sed 's/\ //g' | awk -F"║" '{print $7};')

sudo sed -i "s|"cc763c8ca9fe48508883f6d39f818ccf"|$ICACCESSKEY|g" ei.env
sudo sed -i "s|"jEG8wzejfexfjAeZWBy8SzS7XV+SfV22j0eq7CEnyc6SSsd35PtQlESP2RhYs1am"|$ICSECRET|g" ei.env
sudo sed -i "s|"pKgKE+XNYbU2FRX207LObetsCx56bGPXenU3XpUelAdRb73bXBE22tSLjPviRUav"|$CIACCESSKEY|g" ei.env
sudo sed -i "s|"FXllNVlkD8ADVjFr46teIGRaeWEZXsYVQRMdfmu+UmRV4aysZ30E/OkNadysLZsA"|$CISECRET|g" ei.env

sudo docker exec --env-file ei.env -it plinode /bin/bash -c ". ~/.profile && pm2 start /pluginAdm/startEI.sh"


echo -e "\n\n################# Node Setup completed. Oracle Deployment Part has to be done manually. Please see: https://docs.goplugin.co for forther information #################\n\n"
