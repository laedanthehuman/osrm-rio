#!/bin/bash
DATA_PATH=${DATA_PATH:="/data"}
MAP_LOCATION="http://overpass.osm.rambler.ru/cgi/xapi_meta?*[bbox=-43.795060,-23.076347,-43.101608,-22.746120]"
MAP_NAME="rio"
MAP_EXTENSION="osm"

_sig() {
  kill -TERM $child 2>/dev/null
}

trap _sig SIGKILL SIGTERM SIGHUP SIGINT EXIT

echo "Using data container.."

# Use data container.
if [ ! -f $DATA_PATH/$MAP_NAME.osrm ]; then
  if [ ! -f $DATA_PATH/$MAP_NAME.$MAP_EXTENSION ]; then
    echo "Downloading maps..."
    wget -O $DATA_PATH/$MAP_NAME.$MAP_EXTENSION $MAP_LOCATION || exit 1
    echo "Maps downloaded."
  fi
  ./osrm-extract -p "profile.lua" $DATA_PATH/$MAP_NAME.$MAP_EXTENSION && \
  ./osrm-prepare $DATA_PATH/$MAP_NAME.osrm && \
  rm $DATA_PATH/$MAP_NAME.$MAP_EXTENSION
fi

./osrm-routed $DATA_PATH/$MAP_NAME.osrm --max-table-size 8000 &
child=$!
wait "$child"

