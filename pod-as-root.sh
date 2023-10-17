#!/bin/bash

Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White
NC='\033[0m'              # No Color

function getContainerID(){
	kubectl get pod -n $1 $2 -o jsonpath="{.status.containerStatuses[].containerID}" | sed 's,.*//,,'
}
echo -e "${Green}----------------------------------------------------------------------${NC}"
kubectl get namespace ## | awk '{print $1}'
read -p "Enter Namespace: " namespace
echo -e "${Green}----------------------------------------------------------------------${NC}"
kubectl get pods -n $namespace
echo -e "${Green}----------------------------------------------------------------------${NC}"
read -p "Enter Pod name: " pod
echo -e "${Green}----------------------------------------------------------------------${NC}"

newcontainerID=$(getContainerID ${namespace} ${pod})

echo -e "Welcome to Pod:${Green} ${pod} ${NC}with containerIP:${Yellow} ${newcontainerID} ${NC}"
echo -e "To exit type :${Cyan} exit ${NC}"
echo -e "${Green}----------------------------------------------------------------------${NC}\n"

docker exec -it -u root $newcontainerID /bin/bash