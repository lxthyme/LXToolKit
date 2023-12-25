#!/bin/bash
# This script is designed to increment the build number consistently across all
# targets.

# Navigating to the 'carbonwatchuk' directory inside the source root.
# cd "$SRCROOT/$PRODUCT_NAME/Configuration/Common"

key_version='MARKETING_VERSION'
file_config='Common.xcconfig'

# Get the current date in the format "YYYYMMDD".
current_date=$(date "+%Y%m%d")

# Parse the 'Config.xcconfig' file to retrieve the previous build number.
# The 'awk' command is used to find the line containing "BUILD_NUMBER"
# and the 'tr' command is used to remove any spaces.
previous_build_number=$(awk -F "=" '/'$key_version' = / {print $2}' $file_config | tr -d ' ')

# Extract the date part and the counter part from the previous build number.
previous_date="${previous_build_number:0:8}"
counter="${previous_build_number:8}"

# If the current date matches the date from the previous build number,
# increment the counter. Otherwise, reset the counter to 1.
new_counter=$((current_date == previous_date ? counter + 1 : 1))

# Combine the current date and the new counter to create the new build number.
new_build_number="${current_date}${new_counter}"

echo "-->build_number: $previous_build_number -> $new_build_number"

# Use 'sed' command to replace the previous build number with the new build
# number in the 'Config.xcconfig' file.
sed -i -e "/$key_version =/ s/= .*/= $new_build_number/" $file_config

# Remove the backup file created by 'sed' command.
rm -f $file_config-e
