#!/bin/bash
for filename in ./*.tar; do
    [ -e "$filename" ] || continue
        myFolder=${filename%.tar}

        echo 'Decompressing '"$filename"
        tar -xvf "$filename"

        if [ -f "$myFolder"/ncs_generation_date.txt ]; then
                echo "Removing ""$myFolder""/ncs_generation_date.txt"
                rm "$myFolder"/ncs_generation_date.txt
        fi

        if [ -d "$myFolder"/ncs/ ]; then
                if [ ! "$(ls -A "$myFolder"/ncs/)" ]; then
                        echo "Removing empty directory ""$myFolder""/ncs/"
                        rm -rf "$myFolder"/ncs/
                fi
        fi

        if [ -d "$myFolder" ]; then
                echo "Removing obsolete file ""$filename"
                rm "$filename"
        fi

        echo "Compressing ""$myFolder"" into tar.gz"
        tar -zcvf "$filename".gz "$myFolder"

        if [ -f "$filename".gz ]; then
                echo "Removing obsolete directory ""$myFolder"
                rm -rf "$myFolder"
        fi
done
