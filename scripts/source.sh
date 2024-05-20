#!/bin/bash

# Function to check if a service is healthy
check_service_health() {
  local service_name=$1
  local status=$(podman inspect --format='{{.State.Health.Status}}' "$service_name")

  if [ "$status" == "healthy" ]; then
    return 0
  else
    return 1
  fi
}

CONTAINER_ID=$(podman ps --quiet  --no-trunc --filter "name=oracle_adb-free_1")

echo "The container ID is:"
echo "$CONTAINER_ID"
alias adb-cli="podman exec $CONTAINER_ID adb-cli"
echo "adb-cli command is set"

# Wait for the dependent service to be healthy
while ! check_service_health "oracle_adb-free_1"; do
  echo "Waiting for container to be healthy..."
  sleep 20
done

echo "Container is healthy now"

podman exec -it $CONTAINER_ID /bin/sh /u01/scripts/db-config.sh

# podman exec --interactive $CONTAINER_ID /bin/bash
# podman exec --it 87ac444b632a /bin/bash


# export TNS_ADMIN=/u01/app/oracle/wallets/tls_wallet
# echo $TNS_ADMIN
# sqlplus admin/Welcome_12345@myatp_low
# begin
# APEX_INSTANCE_ADMIN.set_parameter(
# p_parameter => 'IMAGE_PREFIX',
# p_value => 'https://objectstorage.ca-toronto-1.oraclecloud.com/n/c4u04/b/apex-images/o/23.2.3/images/');
# commit;
# end;
# /

# Set executable permissions for your scripts
# chmod +x /usr/local/bin/your_script1.sh
# chmod +x /usr/local/bin/your_script2.sh
# chmod +x /usr/local/bin/your_script3.sh

# # Execute your main command
# exec "$@"

