#!/bin/sh

#list of packages: android list sdk --all --extended
${ANDROID_HOME}/tools/android list sdk --all --extended >/dev/null


ANDROID_PACKAGES="tools platform-tools"

#echo -e "y" | ${ANDROID_HOME}/tools/android update sdk --filter ${ANDROID_PACKAGES}  --no-ui

for package_index in  ${ANDROID_PACKAGES}
do
  echo "====================================================================="
  echo "Start to install package:  ${package_index}"
  echo "====================================================================="
  # Auto accept license
  echo "y" | ${ANDROID_HOME}/tools/android --silent update sdk --all --filter "${package_index}" --no-ui 1>/dev/null
  echo
  echo
done