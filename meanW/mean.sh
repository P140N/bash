#!/bin/bash



rm out.html

wget  -U "opera" -O out.html "https://www.google.ru/#hl=ru&newwindow=1&q="$@"&tbs=dfn:1&tbo=u&fp=1"










cat out.html

#echo $gurl