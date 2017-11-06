#!/bin/sh
file=$1
#数据库连接信息
#username=bitest
#password=gmcc123
#dbname=yxgdboss
#生产主机数据库连接配置
dataarea=GZ
iniFileName=$BIPROG_ROOT/config/prog.ini
dbname=`$BIPROG_ROOT/bin/iniGetValue.sh $iniFileName oracle ${dataarea}dbname`
username=`$BIPROG_ROOT/bin/iniGetValue.sh $iniFileName oracle ${dataarea}username`
password=`$BIPROG_ROOT/bin/iniGetValue.sh $iniFileName oracle ${dataarea}password`

exe_sql()
{
(
    echo "set termout off;"
    echo "set trimout on;"
    echo "set echo off;"
    echo "set feedback off;"
    echo "$sql;"
    echo "commit;"
    echo "quit;"
)|sqlplus -S -L $username/$password@$dbname
}

awk -F"\t" '{print $1" "$2}'  $file |while read  ds_id sql
do
echo ==============$ds_id===========
exe_sql
done