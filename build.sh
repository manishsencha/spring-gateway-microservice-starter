#!/usr/bin/env bash
list_of_dir=$(ls -d */)

cwd=$(pwd)
echo "Current Working Directory : --> $cwd"

echo  "List of Directories : --> $list_of_dir"

for dir in $list_of_dir ; do
    echo "Changing directory : --> $dir"
    cd "$cwd"/"$dir"
    echo "Current Directory : --> $(pwd)"
    echo "Building jar : --> $dir"

    mvn clean install
    if [ $? -eq 0 ]; then
      echo "Build Success : --> $dir"
      mv target/*.jar ../*.jar
      echo "Moving Build : --> $dir"
    else
      echo "Build Failed : --> $dir"
    fi

done