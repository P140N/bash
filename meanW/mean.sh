#!/bin/bash



rm out.html

wget -qO- -U "Firefox/3.0.15"  "https://www.google.ru/#hl=ru&newwindow=1&q="$@"&tbs=dfn:1&tbo=u&fp=1" \
    | grep -Po '(?<=<li>)[^<]+' \
    | nl \
    | perl -MHTML::Entities -pe 'decode_entities($_)' 2>/dev/null; 








