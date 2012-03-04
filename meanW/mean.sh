#!/bin/bash

line="mtg"

line=`echo "$line" | sed -e 's/  */+/g'`

echo $line



gurl="http://www.google.ru/search?aq=f&sourceid=chrome&ie=UTF-8&q=grep#q=grep&hl=ru&newwindow=1&tbo=1&tbas=0&prmd=imvns&tbas=0&source=lnt&sa=X&psj=1&ei=fIJTT6_6FsaP4gSKmc2yDQ&ved=0CAkQpwUoAA&bav=on.2,or.r_gc.r_pw.r_qf.,cf.osb&fp=83dfb3607a629f40&biw=1280&bih=890"
#curl -L 'http://www.google.ru/search?q=microsoft&tbs=dfn:1' 2>&1

rm out.html

wget -q -U "Chrome 17.0.963.56" -O out.html $gurl

wurl=`echo "$gurl" | sed -n '/Heroes /,/Might and Magic/p'`

echo $wurl


define() { 
    wget -qO- -U firefox  "http://www.google.com/search?q=define:$@" \
    | grep -Po '(?<=<li>)[^<]+' \
    | nl \
    | perl -MHTML::Entities -pe 'decode_entities($_)' 2>/dev/null; 
}


count=1	

grep "League of Legends" file.txt
grep "^.*microsoft.*$" out.html
cat out.txt | while read line
do
	#count=$[$count+1]
	echo "$line" | grep "^.*echo.*$"
	#line=`echo "$line" | sed -e :a -e 's/<[^>]*>//g;/</N;//ba'`
	wtf=1
	if [ $count -eq 120 ]
    then
		line=`echo "$line" | sed -e :a -e 's/<[^>]*>//g;/</N;//ba'`
		echo $line
	fi
 
done

cat out.html

#echo $gurl