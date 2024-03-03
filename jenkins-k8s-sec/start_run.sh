#!/bin/bash

source envs.sh
cd installation/
sudo chmod +x jenkins.sh docker.sh trivy.sh node_exporter.sh && cd ..
bash installation/jenkins.sh    # this will installl jenkins
bash installation/docker.sh

# Run Sonarqube 
docker run -d --name sonar -p 9000:9000 sonarqube:lts-

bash installation/trivy.sh
bash installation/node_exporter.sh

bash installation/kubectl.sh