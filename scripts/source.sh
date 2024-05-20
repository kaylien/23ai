#!/bin/bash

CONTAINER_ID=$(podman ps --quiet  --no-trunc --filter "name=oracle_adb-free_1")

echo "The container ID is:"
echo "$CONTAINER_ID"
alias adb-cli="podman exec $CONTAINER_ID adb-cli"
echo "adb-cli command is set"