#!/bin/bash

i=0
rdy=0
pass=0000

while [ $rdy -eq 0 ]
do
    echo "$pass"
    rm -f tex2html-test.tar
    if 7z x -p$pass tex2html-test.tar.7z >/dev/null 2>&1
    then
        echo "I think that the password is  $pass "
        rdy=1
    else
        i=$[i + 1]
        pass=$i
		while [ ${#pass} -ne 4 ]
		do
			pass="0$pass"
		done
        if [ $i -gt 9999 ]
        then
            echo "fail"
            exit 1
        fi
    fi
done

tar -xf tex2html-test.tar


exit 0