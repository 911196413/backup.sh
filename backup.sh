#!/bin/sh
#====================================================================
# vps_auto_backup.sh
# ver 1.0  2014.6.1
# ver 1.1  2014.6.6
# ver 1.2  2014.6.7
# ver 1.3  2014.6.15 增加mysql data备份
# ver 1.4  2014.7.11 增加apache2.conf备份
# thanks by b3log H  and tomaer
# 感谢来自b3log社区的H和tomaer大牛
# link http://cx7863.blog.163.com/blog/static/228650026201442811529963/
#============================mysql变量================================
name=`date +%Y%m%d%H%M%S`
#MYSQL_HOST=`127.0.0.1`
MYSQL_USER=****
MYSQL_PWD=****
#MYSQL_DATA=zjwdb_51358
MYSQL_PATH=/var/www/web.backup/mysql/
#============================web变量==================================
WEB_BACKDIR=/var/www/web.backup/web/
#============================ftp变量==================================
FTP_HOST=mail.****.cn
FTP_USER=****
FTP_PWD=****
FTP_BACKUP_PATH=/
MYSQL_PATH=/var/www/web.backup/mysql
WEB_PATH=/var/www/web.backup/web
#=============================mysql自动备份============================
mysqldump ej_caska -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/ej_caska_$name.sql
mysqldump haobangshou -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/haobangshou_$name.sql
mysqldump kognd -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/kognd_$name.sql
mysqldump c32_discuz_bbs -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/c32_discuz_bbs_$name.sql
mysqldump c32_19aqbbs -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/c32_19aqbbs_$name.sql
#mysqldump c32_discuz_bbs -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/c32_discuz_bbs_$name.sql
#mysqldump c32_discuz_bbs -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/c32_discuz_bbs_$name.sql
#mysqldump c32_discuz_bbs -u$MYSQL_USER -p$MYSQL_PWD > $MYSQL_PATH/c32_discuz_bbs_$name.sql
cd $MYSQL_PATH
tar zcvf ej_caska_$name.sql.tar.gz ej_caska_$name.sql
tar zcvf haobangshou_$name.sql.tar.gz haobangshou_$name.sql
tar zcvf kognd_$name.sql.tar.gz kognd_$name.sql
tar zcvf c32_19aqbbs_$name.sql.tar.gz c32_19aqbbs_$name.sql
tar zcvf c32_discuz_bbs_$name.sql.tar.gz c32_discuz_bbs_$name.sql
#tar zcvf c32_discuz_bbs_$name.sql.tar.gz c32_discuz_bbs_$name.sql
#tar zcvf c32_discuz_bbs_$name.sql.tar.gz c32_discuz_bbs_$name.sql
#tar zcvf c32_discuz_bbs_$name.sql.tar.gz c32_discuz_bbs_$name.sql
#=========================自动删除15天前的mysql备份=====================
rm -rf $MYSQL_PATH/*.sql             #自动每次删除备份出来的sql文件
rm -rf $MYSQL_PATH/c32_discuz_bbs_$(date +%Y%m%d%H%M%S -d "7 days ago").sql.tar.gz
rm -rf $MYSQL_PATH/ej_caska_$(date +%Y%m%d%H%M%S -d "7 days ago").sql.tar.gz
rm -rf $MYSQL_PATH/haobangshou_$(date +%Y%m%d%H%M%S -d "7 days ago").sql.tar.gz
rm -rf $MYSQL_PATH/kognd_$(date +%Y%m%d%H%M%S -d "7 days ago").sql.tar.gz
rm -rf $MYSQL_PATH/c32_19aqbbs_$(date +%Y%m%d%H%M%S -d "7 days ago").sql.tar.gz
#rm -rf $MYSQL_PATH/zjwdb_51358_$(date +%Y%m%d%H%M%S -d "7 days ago").sql.tar.gz
#=============================web自动备份==============================
cd $WEB_BACKDIR
tar zcvf apache2_$name.tar.gz /etc/apache2/sites-available/default     #====apache2备份===========
tar zcvf apache2.conf_$name.tar.gz /etc/apache2/apache2.conf    #====apache2备份===========
tar zcvf mysql_$name.tar.gz /var/lib/mysql/           #===========mysql自动备份=========
tar zcvf crontab_$name.tar.gz /etc/crontab            #==========定时任务自动备份=======
tar zcvf www.coagent.cn_$name.tar.gz /var/www/www.coagent.cn/
tar zcvf www.kognd.cn_$name.tar.gz /var/www/www.kognd.cn/
tar zcvf xswl.caska.cn_$name.tar.gz /var/www/xswl.caska.cn/
tar zcvf forum.19aq.com_$name.tar.gz /var/www/bbs.19aq.com/
tar zcvf bbs.caska.cn_$name.tar.gz /var/www/bbs.caska.cn/
#tar zcvf bbs.caska.cn_$name.tar.gz /var/www/bbs.caska.cn/
#tar zcvf bbs.caska.cn_$name.tar.gz /var/www/bbs.caska.cn/
#=========================自动删除15天前的web备份=======================
rm -rf $WEB_BACKDIR/bbs.caska.cn_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
rm -rf $WEB_BACKDIR/www.coagent.cn_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
rm -rf $WEB_BACKDIR/www.kognd.cn.com_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
rm -rf $WEB_BACKDIR/xswl.caska.cn_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
rm -rf $WEB_BACKDIR/forum.19aq.com_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
#rm -rf $WEB_BACKDIR/bbs.xiaohai2012.com_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
#rm -rf $WEB_BACKDIR/bbs.xiaohai2012.com_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
#rm -rf $WEB_BACKDIR/bbs.xiaohai2012.com_$(date +%Y%m%d%H%M%S -d "7 days ago").tar.gz
#=========================自动上传FTP备份===============================
ftp -n<<EOF
open $FTP_HOST
user $FTP_USER $FTP_PWD
binary
hash
cd $FTP_BACKUP_PATH
lcd $MYSQL_PATH
put ej_caska_$name.sql.tar.gz
put haobangshou_$name.sql.tar.gz
put kognd_$name.sql.tar.gz
put c32_19aqbbs_$name.sql.tar.gz
put c32_discuz_bbs_$name.sql.tar.gz
lcd $WEB_PATH
put apache2_$name.tar.gz
put crontab_$name.tar.gz
put mysql_$name.tar.gz
put apache2.conf_$name.tar.gz
put www.coagent.cn_$name.tar.gz
put www.kognd.cn_$name.tar.gz
put xswl.caska.cn_$name.tar.gz
put forum.19aq.com_$name.tar.gz
put bbs.caska.cn_$name.tar.gz
bye
EOF
