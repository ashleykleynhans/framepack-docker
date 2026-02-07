#!/usr/bin/env bash

export PYTHONUNBUFFERED=1
echo "Starting FramePack"
VENV_PATH=$(cat /workspace/FramePack/venv_path)
source ${VENV_PATH}/bin/activate
cd /FramePack
mkdir -p /workpace/logs
TCMALLOC="$(ldconfig -p | grep -Po "libtcmalloc.so.\d" | head -n 1)"
export LD_PRELOAD="${TCMALLOC}"
nohup python3 demo_gradio.py \
    --server 0.0.0.0 \
    --port 3001 > /workpace/logs/framepack.log 2>&1 &
echo "FramePack started"
echo "Log file: /workpace/logs/framepack.log"
deactivate
