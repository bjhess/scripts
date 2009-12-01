#!/bin/sh
echo "start at `date +%s`"
touch ./file.txt
mkdir ./fileholder

LIMIT=10000

for ((a=1; a <= LIMIT ; a++))
do
  mv ./file.txt fileholder/
  mv ./fileholder/file.txt ./
done

rm ./file.txt
rm -rf ./fileholder

echo "  end at `date +%s`"
exit 0
