<div align="center">

# Docker image for FramePack: Official implementation and desktop software for "Packing Input Frame Context in Next-Frame Prediction Models for Video Generation".

[![GitHub Repo](https://img.shields.io/badge/github-repo-green?logo=github)](https://github.com/ashleykleynhans/framepack-docker)
[![Docker Image Version (latest semver)](https://img.shields.io/docker/v/ashleykza/framepack?logo=docker&label=dockerhub&color=blue)](https://hub.docker.com/repository/docker/ashleykza/framepack)
<br>
![Docker Pulls](https://img.shields.io/docker/pulls/ashleykza/framepack?style=for-the-badge&logo=docker&label=Docker%20Pulls&link=https%3A%2F%2Fhub.docker.com%2Frepository%2Fdocker%2Fashleykza%2Fframepack%2Fgeneral)

</div>

## Available Image Variants

| Docker Image Tag | CUDA | Python | Torch | xformers     | RunPod                                                                      |
|------------------|------|--------|-------|--------------|-----------------------------------------------------------------------------|
| cu124-py311      | 12.4 | 3.11   | 2.6.0 | 0.0.29.post3 | [Deploy](https://console.runpod.io/deploy?template=ttpsmdrpha&ref=2xxro4sy) |
| cu128-py311      | 12.8 | 3.11   | 2.9.1 | 0.0.33       | [Deploy](https://console.runpod.io/deploy?template=ttpsmdrpha&ref=2xxro4sy) |

## Installs

* Ubuntu 22.04 LTS
* [FramePack](
  https://github.com/lllyasviel/FramePack)
* [Jupyter Lab](https://github.com/jupyterlab/jupyterlab)
* [code-server](https://github.com/coder/code-server)
* [runpodctl](https://github.com/runpod/runpodctl)
* [OhMyRunPod](https://github.com/kodxana/OhMyRunPod)
* [RunPod File Uploader](https://github.com/kodxana/RunPod-FilleUploader)
* [croc](https://github.com/schollz/croc)
* [rclone](https://rclone.org/)

## Available on RunPod

This image is designed to work on [RunPod](https://runpod.io?ref=2xxro4sy).

| Name                | Docker Image                          | RunPod Template                                                             |
|---------------------|---------------------------------------|-----------------------------------------------------------------------------|
| FramePack CUDA 12.4 | ashleykza/framepack:cu124-py311-1.0.1 | [Deploy](https://console.runpod.io/deploy?template=ttpsmdrpha&ref=2xxro4sy) |
| FramePack CUDA 12.8 | ashleykza/framepack:cu128-py311-1.0.1 | [Deploy](https://console.runpod.io/deploy?template=ttpsmdrpha&ref=2xxro4sy) |

## Building the Docker image

> [!NOTE]
> You will need to edit the `docker-bake.hcl` file and update `REGISTRY_USER`,
> and `RELEASE`.  You can obviously edit the other values too, but these
> are the most important ones.

```bash
# Clone the repo
git clone https://github.com/ashleykleynhans/framepack-docker.git

# Log in to Docker Hub
docker login

# Build the image, tag the image, and push the image to Docker Hub
cd framepack-docker
docker buildx bake -f docker-bake.hcl --push

# Same as above but customize registry/user/release:
REGISTRY=ghcr.io REGISTRY_USER=myuser RELEASE=my-release docker buildx \
    bake -f docker-bake.hcl --push
```

## Running Locally

### Install Nvidia CUDA Driver

- [Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html)
- [Windows](https://docs.nvidia.com/cuda/cuda-installation-guide-microsoft-windows/index.html)

### Start the Docker container

```bash
docker run -d \
  --gpus all \
  -v /workspace \
  -p 3000:3001 \
  -p 7777:7777 \
  -p 8888:8888 \
  -p 2999:2999 \
  -e VENV_PATH=/workspace/venvs/framepack \
  ashleykza/framepack:cu124-py311-1.0.1
```

Replace `cu124-py311-1.0.1` with your preferred variant and version. See [Available Image Variants](#available-image-variants) for options.

## Ports

| Connect Port | Internal Port | Description          |
|--------------|---------------|----------------------|
| 3000         | 3001          | FramePack            |
| 7777         | 7777          | Code Server          |
| 8888         | 8888          | Jupyter Lab          |
| 2999         | 2999          | RunPod File Uploader |

## Environment Variables

| Variable             | Description                                      | Default                    |
|----------------------|--------------------------------------------------|----------------------------|
| VENV_PATH            | Set the path for the Python venv for the app     | /workspace/venvs/framepack |
| JUPYTER_LAB_PASSWORD | Set a password for Jupyter lab                   | not set - no password      |
| DISABLE_AUTOLAUNCH   | Disable FramePack from launching automatically   | (not set)                  |
| DISABLE_SYNC         | Disable syncing if using a RunPod network volume | (not set)                  |

## Logs

FramePack creates a log file, and you can tail the log instead of
killing the service to view the logs.

| Application | Log file                      |
|-------------|-------------------------------|
| FramePack   | /workspace/logs/framepack.log |

For example:

```bash
tail -f /workspace/logs/framepack.log
```

## Community and Contributing

Pull requests and issues on [GitHub](https://github.com/ashleykleynhans/framepack-docker)
are welcome. Bug fixes and new features are encouraged.

## Appreciate my work?

<a href="https://www.buymeacoffee.com/ashleyk" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>
