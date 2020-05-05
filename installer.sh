#!/usr/bin/env bash

if [ "$#" -lt 1 ]; then
    cat <<End-of-message
Usage: curl -L https://raw.githubusercontent.com/gbmcarlos/skellington/master/installer.sh | bash /dev/stdin <project name> [<GitHub username>]
This script will create a new project next to the current one named after the first arguments passed.
These are the steps this scripts will take:
1. Copy the folder of the current project next to it, with the new name
2. Delete a few files and folders
3. Update references to the old project's name
4. Give the new project a new binding HTTP port based on your input
5. Create the initial commit
6. Install Crossbow
7. Install the project's dependencies

After this script runs, you have a new project ready to push to a Github repository.
Remind your DevOps to:
1. Create a private Github repository for the new project, with the same name
2. Create the staging and production environments and pipeline for the project
3. Create the Sentry project
4. Add the projects resources utilization to the dashboard
End-of-message
exit 2
fi

PROJECT_NAME=$1

if [ ! -z "$2" ]; then
    GITHUB_USERNAME=$2
fi

echo "Downloading Skellington repo..."

# Make the directory for the new project and step into it
mkdir ${PROJECT_NAME} && cd ${PROJECT_NAME}

# Download Skellington's tarball and untar in the new folder
curl -s -L https://github.com/gbmcarlos/skellington/tarball/master | tar xz --strip 1

echo "Preparing ${PROJECT_NAME}..."

# Delete files and folders
rm -f installer.sh .gitmodules
rm -rf src/toolkit

# Replace with the new project name
sed -i '' -e "s/skellington/${PROJECT_NAME}/g" config/nginx.conf
sed -i '' -e "s/skellington/${PROJECT_NAME}/g" composer.json

# Initialize the git repo
## Set the remote if a GitHub username was provided
git init > /dev/null
if [ ! -z ${GITHUB_USERNAME} ]; then
    git remote add origin git@github.com:${GITHUB_USERNAME}/${PROJECT_NAME}.git
fi

# Write the project name as a title in README.md and commit it
echo "#" ${PROJECT_NAME} > README.md
git add README.md
git commit -m "Initial commit"  > /dev/null

# Commit the project's skeleton
## Stage everything but src/app
git add .
git reset -- src/app
git commit -m "Project skeleton created by Skellington" > /dev/null

echo "Installing Toolkit..."

# Install Toolkit
git submodule add --quiet git@github.com:gbmcarlos/toolkit.git src/toolkit > /dev/null
git add .gitmodules
git add src/toolkit
git commit -m "Installed Toolkit" > /dev/null

echo "Installing Composer dependencies..."

# Deploy locally and extract composer.lock
./local/standalone.sh --quiet > /dev/null
docker cp ${PROJECT_NAME}:/var/task/composer.lock .
git add composer.lock
git commit -m "Installed composer dependencies" > /dev/null

echo "Finished! ${PROJECT_NAME} is now ready"