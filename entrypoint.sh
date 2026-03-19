#!/bin/sh

export SPOTIPY_CLIENT_ID="$SPOTIFY_CLIENT_ID"
export SPOTIPY_CLIENT_SECRET="$SPOTIFY_CLIENT_SECRET"

sync_playlists() {
  echo "$PLAYLISTS" | tr ',' '\n' | while IFS= read -r playlist; do
    clean_name=$(basename "$playlist" | cut -d'?' -f1)
    spotdl sync "$playlist" \
      --threads 1 \
      --save-file "/music/${clean_name}.spotdl"
  done
}

sync_playlists

echo "0 */2 * * * /app/entrypoint.sh" | crontab -
crond -f