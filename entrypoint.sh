#!/bin/sh

sync_playlists() {
  echo "$PLAYLISTS" | tr ',' '\n' | while IFS= read -r playlist; do
    spotdl sync "$playlist" --save-file "/music/$(basename $playlist).spotdl"
  done
}

# Run immediately on start
sync_playlists

# Schedule every 2 hours
echo "0 */2 * * * /music/entrypoint.sh" | crontab -
crond -f