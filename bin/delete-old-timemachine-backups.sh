#!/bin/bash

# ---------------------------------------------------------------------------- 
# -------- STOLEN FROM HERE: https://apple.stackexchange.com/a/466576 -------- 
# ---------------------------------------------------------------------------- 


# Assuming you have the backup disk connected & root privileges:

# Get the latest backup to exclude from deletion
latest=$(sudo tmutil latestbackup)
echo "Latest backup is $latest"

# The 4th line after the last space from `tmutil destinationinfo` output
# contains the mount disk name
mountpoint=$(tmutil destinationinfo | awk '{print $NF}' | sed -n '4p')
echo "The mountponint is $mountpoint"

# Delete all backups excluding the latest
backups=$(sudo tmutil listbackups)
# if you want to keep the last, say, 3 backups, pipe "sed '$d'" 3-1=2 times:
# backups=$(sudo tmutil listbackups | sed '$d' | sed '$d')

echo "Generating commands:"
echo "$backups" | while read -r backup_path; do
   timestamp=$(basename "$(dirname "$backup_path")" | sed 's/\.backup$//')
   if [ "$timestamp" != "$(basename "$(dirname "$latest")" | sed 's/\.backup$//')" ]; then
      echo sudo tmutil delete -d "$mountpoint" -t "$timestamp"
   fi
done
echo "if you want to actually delete the backups, please copy and past the commands above."