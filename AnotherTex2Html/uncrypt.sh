#!/bin/bash

unlocked=0

for i in 0 1 2 3 4 5 6 7 8 9; do
	for j in 0 1 2 3 4 5 6 7 8 9; do
		for k in 0 1 2 3 4 5 6 7 8 9; do
			for l in 0 1 2 3 4 5 6 7 8 9; do
			
			pass="$i$j$k$l"				
			echo "try: $pass"
			rm -f tex2html-test.tar
			if 7z x -p$pass tex2html-test.tar.7z >/dev/null 2>&1
			then
				echo "pass $pass is correct"
				unlocked=1	
				
			fi
			
			done
	
		done

	done

done

if [$unlocked -eq 0]
then
	echo "pass not decrypted"				
fi

tar -xf tex2html-test.tar

exit 0