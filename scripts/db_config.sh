#!/bin/bash

echo "Script beginning"
# source db_source.sh
export TNS_ADMIN=/u01/app/oracle/wallets/tls_wallet
echo $TNS_ADMIN
sqlplus admin/Welcome_12345@myatp_low
