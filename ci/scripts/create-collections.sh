#!/usr/bin/env bash

function buildZipsFromSubFolders {
  rootFolder=$(pwd)
  for folder in $1/*; do
    if [ -d "$folder" ]; then
      mkdir -p "assembly/$1"
      cd "${folder}/" && zip -r "${rootFolder}/assembly/$1/${folder#*/}.zip" "." && cd -
    fi
  done
}

function addManifestEntries {
  for folder in $1/*; do
    if [ -d "$folder" ] && [[ $folder != "./assembly" ]]; then
      MANIFEST+=("{ \"name\": \"${folder#*/}\", \"itemType\": \"$2\", \"location\": \"${folder#.}.zip\" }")
    fi
  done
}

function writeManifestFile {
  MANIFEST=($(
    IFS=","
    echo "${MANIFEST[*]}"
  ))
  echo "{\"name\":\"${PWD##*/}\",\"provisioningItems\":[${MANIFEST[@]}]}" | json_pp -json_opt pretty,canonical >assembly/manifest.json
  MANIFEST=()
}

PRODUCT_LINE=${1:-retail}
MANIFEST=()

workspace=$(pwd)
mkdir -p ${workspace}/target/assembly
mkdir -p ${workspace}/target/assembly/${PRODUCT_LINE}
mkdir -p ${workspace}/target/assembly/${PRODUCT_LINE}/collections
mkdir -p ${workspace}/target/assembly/${PRODUCT_LINE}/repositories
if [[ -d "${workspace}/target/assembly/*" ]]; then
  echo "Removing from /target/assembly/*"
  rm -r ${workspace}/target/assembly/*
fi

general_notifications_location=${workspace}/collections/${PRODUCT_LINE}/general-notifications
if [ -d "${general_notifications_location}" ] && [ ! -z "$(ls -A ${general_notifications_location})" ]; then
  echo "Create General Notification package"
  cd ${general_notifications_location}
  buildZipsFromSubFolders placeholders
  addManifestEntries placeholders content-enricher:/placeholder
  buildZipsFromSubFolders templates
  addManifestEntries templates content-enricher:/template
  buildZipsFromSubFolders event-general-notifications
  addManifestEntries event-general-notifications engagement:/event-general-notifications
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/collections/general-notifications-${PRODUCT_LINE}.zip" "." && cd - && rm -rf assembly
fi

custom_engagements_location=${workspace}/collections/${PRODUCT_LINE}/custom-engagements
if [ -d "${custom_engagements_location}" ] && [ ! -z "$(ls -A ${custom_engagements_location})" ]; then
  echo "Create Custom Engagements package for banners"
  cd ${custom_engagements_location}
  buildZipsFromSubFolders placeholders
  addManifestEntries placeholders content-enricher:/placeholder
  cd ${custom_engagements_location}/templates
  buildZipsFromSubFolders banner
  addManifestEntries banner content-enricher:/template
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/collections/custom-engagements-banner-${PRODUCT_LINE}.zip" "." && cd - && rm -rf assembly
fi

custom_engagements_location=${workspace}/collections/${PRODUCT_LINE}/custom-engagements
if [ -d "${custom_engagements_location}" ] && [ ! -z "$(ls -A ${custom_engagements_location})" ]; then
  echo "Create Custom Engagements package for message-center"
  cd ${custom_engagements_location}
  buildZipsFromSubFolders placeholders
  addManifestEntries placeholders content-enricher:/placeholder
  cd ${custom_engagements_location}/templates
  buildZipsFromSubFolders message-center
  addManifestEntries message-center content-enricher:/template
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/collections/custom-engagements-message-center-${PRODUCT_LINE}.zip" "." && cd - && rm -rf assembly
fi

custom_engagements_location=${workspace}/collections/${PRODUCT_LINE}/custom-engagements
if [ -d "${custom_engagements_location}" ] && [ ! -z "$(ls -A ${custom_engagements_location})" ]; then
  echo "Create Custom Engagements package for push"
  cd ${custom_engagements_location}
  buildZipsFromSubFolders placeholders
  addManifestEntries placeholders content-enricher:/placeholder
  cd ${custom_engagements_location}/templates
  buildZipsFromSubFolders push
  addManifestEntries push content-enricher:/template
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/collections/custom-engagements-push-${PRODUCT_LINE}.zip" "." && cd - && rm -rf assembly
fi

custom_engagements_location=${workspace}/collections/${PRODUCT_LINE}/custom-engagements
if [ -d "${custom_engagements_location}" ] && [ ! -z "$(ls -A ${custom_engagements_location})" ]; then
  echo "Create Custom Engagements package for overlays"
  cd ${custom_engagements_location}
  buildZipsFromSubFolders placeholders
  addManifestEntries placeholders content-enricher:/placeholder
  cd ${custom_engagements_location}/templates
  buildZipsFromSubFolders overlays
  addManifestEntries overlays content-enricher:/template
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/collections/custom-engagements-overlays-${PRODUCT_LINE}.zip" "." && cd - && rm -rf assembly
fi

engagement_types_location=${workspace}/collections/${PRODUCT_LINE}/engagement-types
if [ -d "${engagement_types_location}" ] && [ ! -z "$(ls -A ${engagement_types_location})" ]; then
  echo "Create Engagement Types package"
  cd "${engagement_types_location}"
  buildZipsFromSubFolders .
  addManifestEntries . engagement:/engagement-types
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/collections/engagement-types-${PRODUCT_LINE}.zip" "." && cd - && rm -rf assembly
fi

repositories_s3_location=${workspace}/collections/${PRODUCT_LINE}/repositories/repositories-s3
if [ -d "${repositories_s3_location}" ] && [ ! -z "$(ls -A ${repositories_s3_location})" ]; then
  echo "Create Repository package for S3"
  cd "${repositories_s3_location}"
  buildZipsFromSubFolders .
  addManifestEntries . repository
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/repositories/repositories-s3.zip" "." && cd - && rm -rf assembly
fi

repositories_azure_location=${workspace}/collections/${PRODUCT_LINE}/repositories/repositories-azure
if [ -d "${repositories_azure_location}" ] && [ ! -z "$(ls -A ${repositories_azure_location})" ]; then
  echo "Create Repository package for Azure"
  cd "${repositories_azure_location}"
  buildZipsFromSubFolders .
  addManifestEntries . repository
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/repositories/repositories-azure.zip" "." && cd - && rm -rf assembly
fi

repositories_db_location=${workspace}/collections/${PRODUCT_LINE}/repositories/repositories-db
if [ -d "${repositories_db_location}" ] && [ ! -z "$(ls -A ${repositories_db_location})" ]; then
  echo "Create Repository package for Database"
  cd "${repositories_db_location}"
  buildZipsFromSubFolders .
  addManifestEntries . repository
  writeManifestFile
  cd assembly && zip -r "${workspace}/target/assembly/${PRODUCT_LINE}/repositories/repositories-db.zip" "." && cd - && rm -rf assembly
fi