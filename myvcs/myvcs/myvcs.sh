#!/bin/bash
file=$2
function init {
    if [ -r $file ]
    then
        if [ -a .$file ]
        then
            if [ -d .$file ]
            then
                echo "already exists"
            else
                echo ".$file exists"
            fi
        else
            mkdir .$file
            echo "-1" > ".$file/revnum"
            touch ".$file/hd"
            touch ".$file/revhead"
        fi
    else
        echo "$file doesn't exist"
    fi
}
    
function commit {
    if [ ! -r $file ]
    then
        echo "$file doesn't exist"
        exit 1
    fi
 
    if [ ! -d ".$file" ]
    then
        echo "rep doesn't exist"
        exit 2
    fi
 
    if [ ! -r ".$file/revnum" ]
    then
        echo "rep is failed"
        exit 3
    fi
   
    revnum=`cat .$file/revnum`
    let "revnum=revnum+1"
    echo "$revnum" > ".$file/revnum"
 
    diff -u ".$file/hd" "$file" > ".$file/$revnum"
    cp $file ".$file/hd"
    cp $file ".$file/revhead"
}
function status {
    if [ ! -r $file ]
    then
        echo "$file doesn't exist"
        exit 1
    fi
 
    if [ ! -d ".$file" ]
    then
        echo "rep doesn't exist"
        exit 2
    fi
 
    if [ ! -r ".$file/revnum" ]
    then
        echo "rep is failed"
        exit 3
    fi
   
    if diff $file ".$file/revhead" > /dev/null ; 
    then
        echo "Status: stable"
        exit 1
    else
        echo "Status: modified"
        exit 2
    fi
}
function difference {
    if [ ! -r $file ]
    then
        echo "$file doesn't exist"
        exit 1
    fi
 
    if [ ! -d ".$file" ]
    then
        echo "rep doesn't exist"
        exit 2
    fi
 
    if [ ! -r ".$file/revnum" ]
    then
        echo "rep is failed"
        exit 3
    fi
   
    echo diff -u $file ".$file/hd"
}
function update {
    if [ ! -r $file ]
    then
        echo "$file doesn't exist"
        exit 1
    fi
 
    if [ ! -d ".$file" ]
    then
        echo "rep doesn't exist"
        exit 2
    fi
 
    if [ ! -r ".$file/revnum" ]
    then
        echo "rep is failed"
        exit 3
    fi
   
    cp ".$file/hd" $file
    revision=$1
    revnum=`cat .$file/revnum`
    if [ $revision -gt $revnum ]  || [ 0 -gt $revision ]
    then
        echo "Wrong number of revision"
        exit
    fi
    i=$revnum
 
    while [ $i -gt $revision ]
    do
        if [ ! -r ".$file/$i" ]
        then
            echo "rep is failed"
            exit
        fi
        patch -uR $file ".$file/$i"
        let "i=i-1"
    done
    cp $file ".$file/revhead"
}

case $1 in
    'init')
        init
        ;;
    "commit")
        commit
        ;;
    "status")
        status
        ;;
    "diff")  
        difference
        ;;
    "update")
        update $3
        ;;
    *)  
        echo "Unknown command"
        ;;
esac