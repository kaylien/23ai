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


echo "Your tenancy, username, and auth token can be found under 'View Login Info' in LiveLabs."
echo ""

read -p 'What tenancy is your reservation in?: ' tenancy_passvar
read -p 'What is your username?: ' username_passvar
echo ""

lowercase_login="${tenancy_passvar,,}/${username_passvar,,}"

echo "For username, enter in $lowercase_login. Do this all in lowercase."
echo "For password, enter in your auth token copied from View Login Details."

echo ""
podman login yyz.ocir.io

echo ""
read -p 'What workload type do you want for your ADB? [Type ATP or ADW]: ' workload_passvar
echo ""
echo "Make sure the following passwords you select are between 12-30 characters, with at least 1 uppercase letter, 1 lowercase letter, and 1 number."
read -p 'What do you want your Admin Password to be?: ' admin_passvar
read -p 'What do you want your Wallet Password to be?: ' wallet_passvar

echo ""
WORKLOAD_TYPE=$workload_passvar ADMIN_PASSWORD=$admin_passvar WALLET_PASSWORD=$wallet_passvar podman-compose up -d

echo ""
echo ""
cd scripts
echo ""

CONTAINER_ID=$(podman ps --quiet  --no-trunc --filter "name=oracle_adb-free_1")

echo ""
echo "The container ID is:"
echo "$CONTAINER_ID"
echo ""

# Wait for the dependent service to be healthy
while ! check_service_health "oracle_adb-free_1"; do
  echo "Waiting for container to be healthy..."
  sleep 20
done

echo "Container is healthy now"
echo ""

podman exec -it $CONTAINER_ID /bin/sh /u01/scripts/db-config.sh

echo ""
echo "Copy and run this command to setup your ADB CLI:"
echo "alias adb-cli='podman exec $CONTAINER_ID adb-cli'"


