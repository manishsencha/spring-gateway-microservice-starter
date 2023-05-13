#!/bin/bash
list_of_dir=$(ls -d */)

cwd=$(pwd)
echo "Current Working Directory : --> $cwd"

echo  "List of Directories : --> $list_of_dir"

echo "Creating build directory : --> "

mkdir "$cwd/builds"

echo "Latest list of directories : --> $(ls -d */)"

for dir in $list_of_dir ; do
    echo "Changing directory : --> $dir"
    cd "$cwd"/"$dir"
    echo "Current Directory : --> $(pwd)"
    echo "Building jar : --> $dir"
    mvn clean install
    if [ $? -eq 0 ]; then
      echo "Build Success : --> $dir"
      cp "$cwd/$dir"target/*.jar  "$cwd/builds/"
      echo "Moving Build : --> $dir"
    else
      echo "Build Failed : --> $dir"
    fi
done

echo "Listing all builds : -->"

ls "$cwd/builds"

GITHUB_USER=manishsencha
GITHUB_TOKEN=$API_TOKEN_GITHUB
GITHUB_REPOSITORY=spring-gateway-microservice-starter-builds

echo "Cloning repo : -->"
git clone "https://$GITHUB_USER:$GITHUB_TOKEN@github.com/$GITHUB_USER/$GITHUB_REPOSITORY" "$cwd/dest-repo"

echo "Copying required files : -->"
cp "$cwd/builds/*" "$cwd/dest-repo"

echo "Changing Directory : -->"
cd "$cwd/dest-repo"

echo "Performing Git Actions : -->"
git add .

git commit -m "Build"

git push


