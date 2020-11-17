docker image rm -f $(docker images | grep "none" | awk '{print $3}')
