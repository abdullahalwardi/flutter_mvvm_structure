#!/bin/bash
function export_files() {
    # find all files in directory not recursively
    files=$(find $1 -maxdepth 1 -type f)
    filename="$1/$(echo $1 | rev | cut -d'/' -f1 | rev).dart"

    if [ ! -f "$filename" ]; then
        touch "$filename"
    fi

    echo -n "" >"$filename"

    for f in $files; do
        file=$(echo $f | rev | cut -d'/' -f1 | rev)
        if [[ $f != *.g.dart ]] && [[ $f != *.gr.dart ]] && [[ $f != *.freezed.dart ]] && [[ $f != $filename ]] && [[ $file != _* ]] && [[ $f != *DS_Store ]]; then

            echo "export './${f#$1/}';" >>"$filename"
        fi
    done

    # echo $(find $1 -maxdepth 1 -type d)
    if [ "$(find $1 -maxdepth 1 -type d | wc -l)" -gt 1 ]; then
        for d in $(find $1 -maxdepth 1 -type d); do
            if [[ $d != $1 ]]; then
                echo "export './${d#$1/}/${d#$1/}.dart';" >>"$filename"
            fi
        done
    fi
}

# read all directories from ./export.json file and export files
for dir in $(cat ./export.json | jq -r '.[]'); do
    export_files $dir
done
