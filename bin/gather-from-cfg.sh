#!/bin/bash

# This program will collect all of the data from the fields specified below
# for all of the config files given as arguments
#

# Arugment is directory to look in
DIR="$1"

# Change into the directory to make this easier
pushd $DIR > /dev/null

# These are the fields to gather from the data
#FIELDS=(
#  sim_IPC
#  il1.hits il1.misses
#  dl1.hits dl1.misses
#  ul2.hits ul2.misses
#  dtlb.hits dtlb.misses
#)
FIELDS=${@:2}

# Get all the conf files
CFG_FILE_ENDING="cfg.out"

# The label for the csv
label=$(echo "config_file" $FIELDS | sed 's/ /, /g')
echo $label

# Print the csvs of gathered data for each config file in the argument list
for conffile in *"${CFG_FILE_ENDING}"*
do

  experiment=$(echo $conffile | sed -e 's/\(\.cfg\.out\)*$//g')
  printf $experiment

  for field in ${FIELDS[@]}
  do
    grep $field $conffile | awk '{ printf(", %s"), $2 }'
  done

  echo

done

# Restore the directory state
popd > /dev/null
