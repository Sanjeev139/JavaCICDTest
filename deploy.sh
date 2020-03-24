#!/usr/bin/env bash

# A simple deployment script in lieu of CD through GitLab or other CI/CD tool
# This script should not be used for automation as it does not provide adequate error handling

if [[ -z $1 ]]; then
    echo "A tag is required to deploy"
    exit 10
fi

BRANCH=`git symbolic-ref --short HEAD`

echo "Checking out $1"
git checkout $1

echo "Deploying..."
mvn clean deploy -P release
echo "Deploy finished with code $?"

echo "Returning to branch $BRANCH"
git checkout ${BRANCH}
