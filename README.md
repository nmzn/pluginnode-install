# pluginnode-install

# Please take note that the "./install_node.sh" does not include the docker installation. If you have no Docker installed on your VPS you need to run the "./install_docker.sh" first

The install Script hasnt a password check yet. Will include that in later updates.

Contents:

  ##install_docker.sh

      Thist is a small Script that installs docker for you.
  
  ##install_node.sh
  
      This ist the main Install Script that will install the plugin Node including the external initiator.
      
    
  Step 1:
      
      cd # to be sure you run it from the correct directory
      
      sudo git clone https://github.com/nmzn/pluginnode-install.git && cd pluginnode-install && sudo chmod +x install_docker.sh && sudo chmod +x install_node.sh
      
  
  Step 2 (optional if needed):
      
          ./install_docker.sh
  
  Step 3:
  
          ./install_node.sh
          
    
   #This does not include any changings to your Firewall you may need to apply in order for the node to run correctly. 
    
   #Important
   
   Keep in mind that you still have to do the Oracle Contract deployment part wich you find here: https://docs.goplugin.co
   
