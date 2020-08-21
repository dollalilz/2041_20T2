#!/bin/dash

backup=".snapshot.$1"

delete(){
    for i in *
    do
    if cmp -s "$i" "snapshot-save.sh"
    then 
        continue 
    else
        # echo $i 
        rm "$i"
    fi
    done
}

if test -d $backup
then
    sh snapshot-save.sh
    delete
    echo "Restoring snapshot $1"
    cp -a "$backup/." .
fi


#sh snapshot-save.sh

