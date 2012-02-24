#!/bin/bash
endOfParIfNeed() {
    if [ $parStatus -eq 1 ]
    then
        echo "</p>"
        parStatus=0
    fi
}

read -r head

cat << EOF
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>$head</title>
</head>
<body>
EOF

parStatus=0

while read -r line
do
    line=`echo "$line" | sed -e 's/.*%.*//'` 
    line=`echo "$line" | sed -e 's/   */ /g'` # 2 or more space 2 1
    if [ ${#line} -gt 0 ]
    then
        if echo "$line" | grep "^\\\section{.*}$" >/dev/null 2>&1
        then
            endOfParIfNeed
            line=${line:9:$[${#line} - 10]}
            echo "<h1>$line</h1>"
        else
            if echo "$line" | grep "^\\\subsection{.*}$" >/dev/null 2>&1
            then
                endOfParIfNeed
                line=${line:12:$[${#line} - 13]}
                echo "<h2>$line</h2>"
            else
                if [ $parStatus -eq 0 ]
                then
                    echo -n "<p>$line"
                    parStatus=1
                else
                    echo ""
                    echo -n "$line"
                fi
            fi
        fi
    else
        endOfParIfNeed
    fi
done

endOfParIfNeed

cat << EOF
</body>
</html>
EOF

exit 0