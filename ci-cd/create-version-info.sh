#!/usr/bin/env bash
export set VERSIONFILE="app/views/version/_version.html.erb"

echo "IMI-Maps @" > "$VERSIONFILE"
echo $IMIMAPS_ENVIRONMENT >> "$VERSIONFILE"
echo $RAILS_ENV >> "$VERSIONFILE"
git rev-parse --short HEAD >> "$VERSIONFILE"
echo "TAG: <%= ENV['TAG'] %>" >> "$VERSIONFILE"
