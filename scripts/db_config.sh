#!/bin/bash

echo "Script beginning"
# source db_source.sh
export TNS_ADMIN=/u01/app/oracle/wallets/tls_wallet
echo $TNS_ADMIN
sqlplus admin/Welcome_12345@myatp_low
begin
APEX_INSTANCE_ADMIN.set_parameter(
p_parameter => 'IMAGE_PREFIX',
p_value => 'https://objectstorage.ca-toronto-1.oraclecloud.com/n/c4u04/b/apex-images/o/23.2.3/images/');
commit;
end;
/
