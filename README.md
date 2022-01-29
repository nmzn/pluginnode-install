# pluginnode-install

The install Script hasnt a password check yet. Will include that in later updates.

Contents:

  ##install_docker.sh

      Thist is a small Script that installs docker for you.
  
  ##install_node.sh
  
      This ist the main Install Script that will install the plugin Node including the external initiator.
      
    
  Step 1:
      
      cd # to be sure you run it from the correct directory
      
      sudo git clone https://github.com/nmzn/pluginnode-install.git && cd ..
      
      sudo chmod +x install_docker.sh (optional)
      sudo chmod +x install_node.sh
  
  Step 2:
  
      ./install_node
          
          sudo chmod +x install_docker.sh (optional)
          sudo chmod +x install_node.sh
      
      Step 2:
      
          ./install_node.sh
          
    
   #This does not include any changings to your Firewall you may need to apply in order for the node to run correctly. 
    
   #Important
   
   Keep in mind that you still have to do the Oracle Contract deployment part wich you find here: htts://docs.goplugin.co
   
