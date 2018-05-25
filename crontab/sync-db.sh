KEY=`aws s3 ls $BUCKET --recursive | sort | tail -n 1 | awk '{print $4}'`
aws s3 cp s3://$BUCKET/$KEY latest-backup.sql.gz
gunzip < latest-backup.sql.gz | mysql -u $MYSQL_USER -p"$MYSQL_PASSWORD" $MYSQL_DATABASE
