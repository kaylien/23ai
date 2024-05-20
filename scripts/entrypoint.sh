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

# Wait for the dependent service to be healthy
while ! check_service_health "oracle_adb-free-1"; do
  echo "Waiting for container to be healthy..."
  sleep 5
done

echo "Container is healthy now"

# Set executable permissions for your scripts
# chmod +x /usr/local/bin/your_script1.sh
# chmod +x /usr/local/bin/your_script2.sh
# chmod +x /usr/local/bin/your_script3.sh

# # Execute your main command
# exec "$@"
