#!/usr/bin/env bash

# This is a quick and easy script to automate pom file updates without using ma
# This script should not be used for automation as it does not provide adequate error handling

RELEASE_NAME="test1203-$1"
RELEASE_COMMIT_MESSAGE="release/$RELEASE_NAME"
DEV_COMMIT_MESSAGE="development/$2"

if [[ -z "$1" ]] || [[ -z "$2" ]]; then
    echo "Release version and next version are required"
    exit 10
fi

echo "Updating pom.xml version for release to $1"
mvn versions:set -DnewVersion=$1
mvn versions:commit

echo "Creating release commit: $RELEASE_COMMIT_MESSAGE"
git add pom.xml
git commit -m ${RELEASE_COMMIT_MESSAGE}

echo "Creating release tag: $RELEASE_NAME"
git tag -a ${RELEASE_NAME} -m ${RELEASE_COMMIT_MESSAGE}

echo "Updating pom.xml version for development to $2"
mvn versions:set -DnewVersion=$2
mvn versions:commit

echo "Creating development commit: $DEV_COMMIT_MESSAGE"
git add pom.xml
git commit -m ${DEV_COMMIT_MESSAGE}

echo "Release process finished and ready for review"
echo "Push tag to server using:"
echo "git push origin $RELEASE_NAME"