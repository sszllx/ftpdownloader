#!/bin/bash

destdir=./ioslogs
ioslog=$(ncftpls -u ftpuser -p fa322Agwug ftp://123.59.134.139/ioslogs | sort | grep -v bak | tail -n 1)
ioslog=$(echo | awk '{split("'${ioslog}'", array, "/");print array[2]}')

echo $ioslog

ncftpget -u ftpuser -p fa322Agwug ftp://123.59.134.139/ioslogs/$ioslog

cat $ioslog | awk '{print $1"\t"$2"\t"$3}' > immediate.id

linenum=$(wc -l immediate.id | awk '{print $1}' | xargs -i echo '{}/5' | bc)
split -l $linenum immediate.id


cat xaf >> xae
rm xaf
mv xaa $destdir/1
mv xab $destdir/2
mv xac $destdir/3
mv xad $destdir/4
mv xae $destdir/5

md5val=$(md5sum immediate.id | awk '{print $1}')
echo $md5val

bak_dir=$(echo | awk '{split("'${ioslog}'", array, ".");print array[5]}')
echo $bak_dir

mkdir $bak_dir
mv $ioslog $bak_dir

echo $md5val > $destdir/md5

echo "finish"
