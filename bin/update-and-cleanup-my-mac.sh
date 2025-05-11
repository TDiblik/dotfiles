#!/usr/bin/env bash

### Constants ###
DAYS_TO_KEEP=7

### Init info ###
echo -e "\nBefore cleanup:"
free_storage=$(df -k / | awk 'NR==2 {print $4}')
total_storage=$(df -k / | awk 'NR==2 {print $2}')
free_storage_gb=$(echo "scale=2; $free_storage / 1024 / 1024" | bc)
total_storage_gb=$(echo "scale=2; $total_storage / 1024 / 1024" | bc)
echo "Free storage: $free_storage_gb Gi / Total storage: $total_storage_gb Gi"

echo "Setting nvm..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

echo "Requesting sudo permissions..."
sudo -v

set -x

### Updates ###
brew update 
brew upgrade --greedy 
brew reinstall librewolf --no-quarantine

msfupdate || true

### Cleanups ###
echo "Cleaning up after brew..."
brew autoremove
brew cleanup 

echo "Cleaning up after nvm & node..."
nvm cache clear
for version in $(nvm ls --no-colors | awk '{print $1}' | grep -E '^v[0-9]+\.[0-9]+\.[0-9]+$'); do
    nvm use $version
    npm cache clean --force
    yarn cache clean || true
    pnpm store prune || true
done

echo "Cleaning up after docker..."
docker volume prune -f 
docker image prune -f 
docker builder prune -f

echo "Cleaning up after rust..."
cargo cache -e

echo "Cleaning up after go..."
go clean 
go clean -cache 
go clean -modcache 
go clean -testcache 
go clean -fuzzcache

echo "Cleaning up after C#..."
dotnet nuget locals --clear all

echo "Cleaning up after Java..."
rm -r $HOME/.gradle/caches/

echo "Cleaning up after Ruby..."
gem cleanup &>/dev/null

echo "Cleaning up ~/.cache/..."
rm -r $HOME/.cache/*

# echo "Cleaning up system cache files older than ${DAYS_TO_KEEP} days..."
sudo find /Library/Caches/* -type f -mtime +${DAYS_TO_KEEP} \( ! -path "/Library/Caches/com.apple.amsengagementd.classicdatavault" \
                                               ! -path "/Library/Caches/com.apple.aned" \
                                               ! -path "/Library/Caches/com.apple.aneuserd" \
                                               ! -path "/Library/Caches/com.apple.iconservices.store" \) \
    -exec rm {} \; 2>/dev/null || echo "Skipped restricted files in system cache."

echo "Cleaning up user cache files older than ${DAYS_TO_KEEP} days..."
find ~/Library/Caches/* -type f -mtime +${DAYS_TO_KEEP} -exec sudo rm -f {} \; || echo "Skipped restricted files in user cache."

echo "Cleaning up application logs older than ${DAYS_TO_KEEP} days..."
sudo find /Library/Logs -type f -mtime +${DAYS_TO_KEEP} -exec rm {} \; 2>/dev/null || echo "Skipped restricted files in system logs."
find ~/Library/Logs -type f -mtime +${DAYS_TO_KEEP} -exec rm {} \; || echo "Error clearing user logs."

echo "Cleaning up temporary files older than ${DAYS_TO_KEEP} days..."
sudo find /private/var/tmp/* -type f -mtime +${DAYS_TO_KEEP} -exec rm {} \; 2>/dev/null || echo "Skipped restricted files in system tmp."
find /tmp/* -type f -mtime +${DAYS_TO_KEEP} ! -path "/tmp/tmp-mount-*" -exec rm {} \; 2>/dev/null || echo "Skipped restricted tmp files."

echo "Cleaning up Safari caches..."
find ~/Library/Safari/LocalStorage -type f -mtime +${DAYS_TO_KEEP} -exec rm {} \; 2>/dev/null || echo "Error cleaning Safari LocalStorage."
find ~/Library/Safari/WebKit/MediaCache -type f -exec rm {} \; 2>/dev/null || echo "Error cleaning Safari MediaCache."

echo "Cleaning up Spotify cache..."
find ~/Library/Application\ Support/Spotify/PersistentCache/Storage -type f -mtime +${DAYS_TO_KEEP} -exec rm {} \; 2>/dev/null || echo "Error cleaning Spotify cache."

echo "Cleaning up Xcode derived data..."
rm -rf ~/Library/Developer/Xcode/DerivedData/* || echo "Error cleaning Xcode derived data."
rm -rf ~/Library/Developer/Xcode/Archives/* || echo "Error cleaning Xcode archives."
rm -rf ~/Library/Developer/CoreSimulator/Caches/* || echo "Error cleaning CoreSimulator caches."

echo "Cleaning up after time machine..."
for snapshot in $(tmutil listlocalsnapshots / | grep "com.apple.TimeMachine" | awk -F '.' '{print $4}'); do
    echo "Deleting snapshot: $snapshot"
    tmutil deletelocalsnapshots "$snapshot"
done

echo "Cleaning up memory cache..."
sudo purge || echo "Error purging system memory."

echo "Cleaning up node_modules inside my ~/Projects directory..."
find ~/Projects -name "node_modules" -type d -exec rm -rf {} \; 2>/dev/null

echo "Cleaning up nx cache inside my ~/Projects directory..."
find ~/Projects -name ".nx" -type d -exec rm -rf {} \; 2>/dev/null

### Finish info ###

set +x

echo -e "\nInfo about the biggest folders atm: "
du -h -d 1 ~ 2>/dev/null | sort -hr | head -n 20

echo -e "\nAfter cleanup:"
free_storage_final=$(df -k / | awk 'NR==2 {print $4}')
total_storage_final=$(df -k / | awk 'NR==2 {print $2}')
free_storage_final_gb=$(echo "scale=2; $free_storage_final / 1024 / 1024" | bc)
total_storage_final_gb=$(echo "scale=2; $total_storage_final / 1024 / 1024" | bc)
echo "Free storage: $free_storage_final_gb Gi / Total storage: $total_storage_final_gb Gi"

free_storage_diff_kb=$((free_storage_final - free_storage))
if [ "$free_storage_diff_kb" -lt 0 ]; then
    free_storage_diff_kb=0
fi
if [ "$free_storage_diff_kb" -ge $((1024 * 1024)) ]; then
    free_storage_diff_gb=$(echo "scale=2; $free_storage_diff_kb / 1024 / 1024" | bc)
    echo "Space freed: $free_storage_diff_gb Gi"
elif [ "$free_storage_diff_kb" -ge 1024 ]; then
    free_storage_diff_mb=$(echo "scale=2; $free_storage_diff_kb / 1024" | bc)
    echo "Space freed: $free_storage_diff_mb Mi"
else
    echo "Space freed: $free_storage_diff_kb Ki"
fi

## If you wanna remove more space, go into iCloud Drive -> click folder -> Remove Download
