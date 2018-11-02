#!/bin/bash

set -e

# 本日
datestr=`date +%Y%m%d-%H%M%S`

# バックアップ先
BACKDIR="/root/redmine_backup/backup"

# ファイルバックアップ
tar -czf ${BACKDIR}/file_${datestr}.tar.gz -C /var/lib/redmine/files/ .

# データベースバックアップ
pg_dump -U redmine -w redmine > ${BACKDIR}/db_${datestr}.dump

# 2日前より古いバックアップは削除
find ${BACKDIR} -type f -mtime +2 | xargs rm -f
