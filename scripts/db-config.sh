#!/bin/bash

echo "Setting up the correct APEX images directory..."
# source db_source.sh
export TNS_ADMIN=/u01/app/oracle/wallets/tls_wallet
echo "Your TNS_ADMIN location = $TNS_ADMIN"
sqlplus admin/Welcome_12345@myatp_low