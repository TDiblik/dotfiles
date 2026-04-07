#!/bin/bash

killall bird cloudd fileproviderd
mv ~/Library/Application\ Support/CloudDocs ~/Downloads/CloudDocs_backup
launchctl start com.apple.bird
