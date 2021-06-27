
# DB

Предварительно в директории требуется создать файл доступа к mysql .mylogin.cnf
сохранение всех таблиц DB кроме указаной, упаковка в ZIP архив в указаной директории
````bash
# database backup
# 0 0 * * * /bin/bash -l -c 'mysqldump --login-path=/home/USER_DIR --all-databases --quick --ignore-table=mysql.event | gzip -c -9 > /home/USER_DIR/backups/sql-`date "+\%Y-\%m-\%d"`.gz'
````


# Files

Создание backup каждый месяц 1-го числа
zip.lst - список директорий для обработки
````bash
# files backup (full)
# 30 00 1 * * /usr/bin/zip -r -9 -q "/home/USER_DIR/backups/www-`date "+\%Y-\%m"` files.zip" -x *.git* -x *cache* -x *tmp* -x *log* -@ < zip.lst
````

Создание backup каждый понедельник
````bash
# files backup (diff)
30 01 * * 1 /usr/bin/zip -r -9 -q "/home/USER_DIR/backups/www-`date "+\%Y-\%m"` files.zip" -x *.git* -x *cache* -x *tmp* -x *log* -DF --out "/home/USER_DIR/backups/www-`date "+\%Y-\%m-\%d"` files diff.zip" -@ < zip_lst.txt
````

zip_lst.txt - содержит список директорий для резервирования, по одной на каждой строке
```txt
/var/www
/home
/root
```

# Deleted old files
````bash
find /backup -type f -mtime +45 -name 'www-* files.zip' -type f -delete
````

# Transfer to cloud
## FTP
````bash
40 00 1 * * /bin/bash -l -c 'curl -T "/home/USER_DIR/backups/www-`date "+\%Y-\%m"` files.zip" ftp://backup11.hoztnode.net/vds2/ --user user123456:PASS123456 1> /dev/null 2>&1'
````






