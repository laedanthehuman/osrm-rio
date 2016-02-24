# Docker image for OSRM - Rio de Janeiro

This project lets you prepare and run a docker container with OSRM and the map of the city of Rio de Janeiro.

## Run
By running the container, you will be downloading the maps for the city of Rio de Janeiro, preparing it and then serving it.

Run the container like

```
docker run \
  -d \
  --name osrm-rio \
  -v /data \
  -p 5000:5000 \
  macecchi/osrm-rio
```
