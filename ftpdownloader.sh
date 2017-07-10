#!/bin/bash

ioslog=$(ncftpls -u ftpuser -p fa322Agwug ftp://123.59.134.139/ioslogs | sort | grep -v bak | tail -n 1)

ioslog=$(echo | awk '{split("'${ioslog}'", array, "/");print array[2]}')

echo $ioslog

# ncftpget -u ftpuser -p fa322Agwug ftp://123.59.134.139/ioslogs/$ioslog

cat $ioslog | awk '{print $1"\t"$2"\t"$3}' > test.id

linenum=$(wc -l $ioslog | awk '{print $1}' | xargs -i echo '{}/5' | bc)
split -l $linenum $ioslog

md5val=$(md5sum $ioslog | awk '{print $1}')
echo $md5val

#bak_dir=$(echo | awk '{split("'${ioslog}'", array, ".");print array[5]}')
#echo $bak_dir

#mkdir $bak_dir
#mv $ioslog $bak_dir

echo $md5val > md5

echo "finish"
