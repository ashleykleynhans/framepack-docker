ARG BASE_IMAGE
FROM ${BASE_IMAGE}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=on \
    SHELL=/bin/bash

# Create and use the Python venv
WORKDIR /
RUN python3 -m venv --system-site-packages /venv

# Install torch and xformers
ARG INDEX_URL
ARG TORCH_VERSION
ARG XFORMERS_VERSION
RUN source /venv/bin/activate && \
    pip3 install --no-cache-dir torch==${TORCH_VERSION} torchvision torchaudio --index-url ${INDEX_URL} && \
    pip3 install --no-cache-dir xformers==${XFORMERS_VERSION} --index-url ${INDEX_URL} && \
    deactivate

# Clone the git repo of FramePack and set version
ARG FRAMEPACK_COMMIT
RUN git clone https://github.com/ashleykleynhans/FramePack.git && \
    cd /FramePack && \
    git checkout ${FRAMEPACK_COMMIT}

# Install the dependencies for FramePack
WORKDIR /FramePack
RUN source /venv/bin/activate && \
    pip3 install --upgrade pip && \
    pip3 install --no-cache-dir -r requirements.txt && \
    pip3 install --no-cache-dir gradio==5.25.2 && \
    deactivate

# Install models
COPY --chmod=755 build/download_models.py ./
ENV HF_HOME="/FramePack/hf_download"
RUN source /venv/bin/activate && \
    pip3 install huggingface_hub && \
    python3 /FramePack/download_models.py && \
    deactivate

# Remove existing SSH host keys
RUN rm -f /etc/ssh/ssh_host_*

# NGINX Proxy
COPY nginx/nginx.conf /etc/nginx/nginx.conf

# Set template version
ARG RELEASE
ENV TEMPLATE_VERSION=${RELEASE}

# Set the venv path
ARG VENV_PATH
ENV VENV_PATH=${VENV_PATH}

# Copy the scripts
WORKDIR /
COPY --chmod=755 scripts/* ./

# Start the container
SHELL ["/bin/bash", "--login", "-c"]
CMD [ "/start.sh" ]
