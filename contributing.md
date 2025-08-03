# Contributing

## Building the Image

### Install prerequisits:

Python3, umoci, skopeo, rsync, rpm, zypper

#### Debian

```bash
sudo apt install --yes python3 python3-venv umoci skopeo rsync rpm zypper
```

### Running the Build

```bash
make build
```

This will do all the work needed to setup the Python virtual environment and build the Docker image.

## Running the Image

To get the image into docker, simply `make load`. Docker will unpack the image into your machine.s
