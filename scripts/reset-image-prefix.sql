begin
    APEX_INSTANCE_ADMIN.set_parameter(
    p_parameter => 'IMAGE_PREFIX',
    p_value => 'https://objectstorage.ca-toronto-1.oraclecloud.com/n/c4u04/b/apex-images/o/23.2.3/images/');
    commit;
end;
/