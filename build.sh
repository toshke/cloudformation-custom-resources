#!/bin/bash

BUILD_NUMBER=$1
S3_BUCKET=$2
S3_REGION=$3

if [[ "x" == "x$BUILD_NUMBER" ]]; then
  BUILD_NUMBER="dev"
fi

if [[ "x" == "x$S3_REGION" ]]; then
  S3_REGION="ap-southeast-2"
fi

mkdir -p dist/
npm install
tar cfvz dist/ccr-$BUILD_NUMBER.tar.gz src/ node_modules/

if [[ "x" != "x$S3_BUCKET" ]]; then
  aws s3 cp dist/ccr-$BUILD_NUMBER.tar.gz s3://${S3_BUCKET}/build/ccr-$BUILD_NUMBER.tar.gz --acl public-read --region $S3_REGION
fi
