variable "REGISTRY" {
    default = "docker.io"
}

variable "REGISTRY_USER" {
    default = "ashleykza"
}
variable "APP" {
    default = "framepack"
}

variable "RELEASE" {
    default = "1.0.0"
}

variable "RELEASE_SUFFIX" {
    default = ""
}

variable "CU_VERSION" {
    default = "124"
}

variable "BASE_IMAGE_REPOSITORY" {
    default = "ashleykza/runpod-base"
}

variable "BASE_IMAGE_VERSION" {
    default = "2.4.14"
}

variable "FRAMEPACK_COMMIT" {
    default = "97fe5dbe06ac1f337ece08935b1076a35eefeeb9"
}

variable "VENV_PATH" {
    default = "/workspace/venvs/framepack"
}

group "default" {
    targets = ["cu124-py311"]
}

group "all" {
    targets = [
        "cu124-py311",
        "cu128-py311"
    ]
}

target "cu124-py311" {
    dockerfile = "Dockerfile"
    tags = ["${REGISTRY}/${REGISTRY_USER}/${APP}:cu124-py311-${RELEASE}${RELEASE_SUFFIX}"]
    args = {
        RELEASE          = "${RELEASE}"
        BASE_IMAGE       = "${BASE_IMAGE_REPOSITORY}:${BASE_IMAGE_VERSION}-python3.11-cuda12.4.1-torch2.6.0"
        INDEX_URL        = "https://download.pytorch.org/whl/cu124"
        TORCH_VERSION    = "2.6.0+cu124"
        XFORMERS_VERSION = "0.0.29.post3"
        FRAMEPACK_COMMIT = "${FRAMEPACK_COMMIT}"
        VENV_PATH        = "${VENV_PATH}"
    }
    platforms = ["linux/amd64"]
}

target "cu128-py311" {
    dockerfile = "Dockerfile"
    tags = ["${REGISTRY}/${REGISTRY_USER}/${APP}:cu128-py311-${RELEASE}${RELEASE_SUFFIX}"]
    args = {
        RELEASE                      = "${RELEASE}"
        BASE_IMAGE                   = "${BASE_IMAGE_REPOSITORY}:${BASE_IMAGE_VERSION}-python3.11-cuda12.8.1-torch2.9.1"
        INDEX_URL                    = "https://download.pytorch.org/whl/cu128"
        TORCH_VERSION                = "2.9.1+cu128"
        XFORMERS_VERSION             = "0.0.33"
        FRAMEPACK_COMMIT             = "${FRAMEPACK_COMMIT}"
        VENV_PATH                    = "${VENV_PATH}"
    }
    platforms = ["linux/amd64"]
}

