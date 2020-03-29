#!/bin/bash

GAWK="/bin/gawk"
TIMESTAMP=$(date +"%F %T")
ORIG_FILE="input.csv"
NEW_FILE="output.csv"

#Append 'Create' DateTimeStamp to CSV for MySQL logging
$GAWK -v d="$TIMESTAMP" -F"," 'BEGIN {OFS = ","} {$6=d; print}' $ORIG_FILE > $NEW_FILE
rm -f $ORIG_FILE
