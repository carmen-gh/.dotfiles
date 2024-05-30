#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title yabai restart
# @raycast.mode silent

# Optional parameters:
# @raycast.icon https://github.com/koekeishiya/yabai/blob/master/assets/icon/1x/icon-128px.png

# Execute the command and start-service if it wasn't running
if ! yabai --restart-service; then
    yabai --start-service
fi
