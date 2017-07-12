#!/bin/bash

destdir=./ioslogs
ioslog=$(ncftpls -u ftpuser -p fa322Agwug ftp://123.59.134.139/ioslogs | sort | grep -v bak | tail -n 1)
ioslog=$(echo | awk '{split("'${ioslog}'", array, "/");print array[2]}')

echo $ioslog

ncftpget -u ftpuser -p fa322Agwug ftp://123.59.134.139/ioslogs/$ioslog

awk -F"\t" '$3~/3/{print $1"\t"$2"\t"$3}' $ioslog > immediate.id

linenum=$(wc -l immediate.id | awk '{print $1}' | xargs -i echo '{}/6' | bc)
split -l $linenum immediate.id


mkdir $destdir
cat xag >> xaf
mv xaa $destdir/1.id
mv xab $destdir/2.id
mv xac $destdir/3.id
mv xad $destdir/4.id
mv xae $destdir/5.id
mv xaf $destdir/6.id
rm xag

md5val=$(md5sum immediate.id | awk '{print $1}')
echo $md5val

bak_dir=$(echo | awk '{split("'${ioslog}'", array, ".");print array[5]}')
echo $bak_dir

mkdir $bak_dir
mv $ioslog $bak_dir

echo $md5val > $destdir/md5

echo "finish"
