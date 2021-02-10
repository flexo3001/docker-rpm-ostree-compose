## rpm-ostree compose

This container builds my own Silverblue rpm-ostree image and serves it on port 8000.

### Running the container
#### Using defaults
```docker run --name rpm-ostree-compose --rm -p 8000:8000 --privileged --security-opt label:disable --restart unless-stopped flexo3001/rpm-ostree-compose:latest```

Note: privileged and the label disabling is necessary for bubblewrap.
