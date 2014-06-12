#!/bin/sh
#====================================================================
# vps_auto_backup.sh
# ver 1.0  2014.6.1
# ver 1.1  2014.6.6
# ver 1.2  2014.6.7
# thanks by b3log H  and tomaer
# 感谢来自b3log社区的H和tomaer大牛
# link http://cx7863.blog.163.com/blog/static/228650026201442811529963/
#============================mysql变量================================
name=`date +%Y%m%d%H%M%S`
#MYSQL_HOST=`127.0.0.1`
MYSQL_USER=root
MYSQL_PWD=toor
MYSQL_DATA=zjwdb_51358
MYSQL_PATH=/var/www/web.backup/mysql/
#============================web变量==================================
WEB_BACKDIR=/var/www/web.backup/web/
#============================ftp变量==================================
FTP_HOST=mail.c**a.cn
FTP_USER=ca****014
FTP_PWD=6m**7v
FTP_BACKUP_PATH=/
MYSQL_PATH=/var/www/web.backup/mysql
WEB_PATH=/var/www/web.backup/web
#=============================mysql自动备份============================
mysqldump $MYSQL_DATA -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/zjwdb_51358_$name.sql
cd $MYSQL_PATH
tar zcvf zjwdb_51358_$name.sql.tar.gz zjwdb_51358_$name.sql
#=========================自动删除15天前的mysql备份=====================
rm -rf $MYSQL_PATH/*.sql             #自动每次删除备份出来的sql文件
rm -rf $MYSQL_PATH/zjwdb_51358_$(date +%Y%m%d%H%M%S -d "7 days ago").sql.tar.gz
#=============================web自动备份==============================
cd $WEB_BACKDIR
tar zcvf bbs.xiaohai2012.com_$name.tar.gz /var/www/bbs.xiaohai2012.com/
#=========================自动删除15天前的web备份=======================
rm -rf $WEB_BACKDIR/bbs.xiaohai2012.com_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
#=========================自动上传FTP备份===============================
ftp -n<<EOF
open $FTP_HOST
user $FTP_USER $FTP_PWD
binary
hash
cd $FTP_BACKUP_PATH
lcd $MYSQL_PATH
put zjwdb_51358_$name.sql.tar.gz
lcd $WEB_PATH
put bbs.xiaohai2012.com_$name.tar.gz
bye
EOF
