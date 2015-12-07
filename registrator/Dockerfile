FROM hypriot/rpi-registrator:v6

# docker run -d \
#   --name=registrator \
#   --net=host \
#   --volume=/var/run/docker.sock:/tmp/docker.sock \
#   gliderlabs/registrator:latest \
#     consul://localhost:8500

ENTRYPOINT ["/usr/local/bin/registrator"]
CMD ["-internal consul://consul:8500"]
