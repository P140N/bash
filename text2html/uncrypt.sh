#!/bin/bash

pass=0
m=0
n=0
j=0
i=0
success=0

while [ m -le 9 ]
do
		while [ n -le 9 ]
		do
				while [ j -le 9 ]
				do
						while [ i -le 9 ]
						do
							pass="$m$n$j$i"
							echo "try: $pass"
							rm -f tex2html-test.tar
							if 7z x -p$pass tex2html-test.tar.7z >/dev/null 2>&1
							then
								echo "pass $pass is correct"
								success=1															
							fi
							if [success -ne 1]&&[pass -eq 9999]
								echo "pass not decrypted"
								exit 1
							fi
							if [success -eq 1]
								break  
							fi
							i=$[i + 1]
						done
				if [success -eq 1]
					break  
				fi
				j=$[j + 1]
				done
		if [success -eq 1]
			break  
		fi
		n=$[n + 1]
		done
	if [success -eq 1]
		break  
	fi
	m=$[m + 1]
done

echo "extracting"
tar -xf tex2html-test.tar


exit 0